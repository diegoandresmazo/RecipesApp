//
//  RecipesService.swift
//  RecipesApp
//
//  Created by Diego Andres Mazo Munoz on 31/10/22.
//

import Foundation
import Combine

protocol RecipesServiceType {
    func getRecipes(from query: String) -> AnyPublisher<[Recipe], CloudError>
}

class RecipesService: RecipesServiceType {
    private let baseURL = "https://api.spoonacular.com/recipes/complexSearch?query="
    private let apiKey = "/&apiKey=1b1340a3365742f3af753a9ebf306897"
    
    private let apiService: APIServiceType
    private let session: URLSession
    
    init(apiService: APIServiceType = APIService(), urlSession: URLSession = .shared) {
        self.apiService = apiService
        self.session = urlSession
    }
    
    /**
     * A call is made to the API with the query and then is converted to publisher of Recipe Array
     */
    func getRecipes(from query: String) -> AnyPublisher<[Recipe], CloudError> {
        return search(for: query)
            .map({ recipeResponse -> [Recipe] in
                return recipeResponse.recipes
            })
            .eraseToAnyPublisher()
    }
    
    private func search(for query: String) -> AnyPublisher<RecipeResponse, CloudError> {
        let urlString = baseURL + query + apiKey
        guard let urlWithPercentEncoding = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlWithPercentEncoding) else {
            preconditionFailure("Bad base URL")
        }
        
        let request = URLRequest(url: url)
        return apiService.call(request, urlSession: session, type: RecipeResponse.self)
            .eraseToAnyPublisher()
    }
}
