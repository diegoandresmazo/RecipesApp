//
//  RecipeDetailService.swift
//  RecipesApp
//
//  Created by Diego Andres Mazo Munoz on 1/11/22.
//

import Foundation
import Combine

protocol RecipeDetailServiceType {
    func getRecipe(from id: Int) -> AnyPublisher<RecipeDetail, CloudError>
}

class RecipeDetailService: RecipeDetailServiceType {
    private let baseURL = "https://api.spoonacular.com/recipes/"
    private let informationURL = "/information?includeNutrition=false"
    private let apiKey = "/&apiKey=1b1340a3365742f3af753a9ebf306897"
    
    private let apiService: APIServiceType
    private let session: URLSession
    
    init(apiService: APIServiceType = APIService(), urlSession: URLSession = .shared) {
        self.apiService = apiService
        self.session = urlSession
    }
    
    /**
     * A call is made to the API with the recipe id.
     */
    func getRecipe(from id: Int) -> AnyPublisher<RecipeDetail, CloudError> {
        let urlString = baseURL + String (id) + informationURL + apiKey
        guard let urlWithPercentEncoding = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlWithPercentEncoding) else {
            preconditionFailure("Bad base URL")
        }
        
        let request = URLRequest(url: url)
        return apiService.call(request, urlSession: session, type: RecipeDetail.self)
            .eraseToAnyPublisher()
    }
}
