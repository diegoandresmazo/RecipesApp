//
//  RecipeListViewModel.swift
//  RecipesApp
//
//  Created by Diego Andres Mazo Munoz on 31/10/22.
//

import Foundation
import Combine
import OSLog

final class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var notResults: Bool = false
    @Published var isLoading: Bool = false
    @Published var showErrorStatus: Bool = false
    
    private let recipesService: RecipesService
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    var errorIcon: String = Icons.System.errorIcon
    var errorTitle: String = "We did not find recipes"
    var errorDescription: String = "Check that the word is spelled correctly. You can also try fewer or more general terms."
    
    init(recipesService: RecipesService = RecipesService()) {
        self.recipesService = recipesService
    }
    
    func search(name: String) {
        self.isLoading = true
        recipesService.getRecipes(from: name)
            .sink { [weak self] errorCompletion in
                if case .failure(let err) = errorCompletion {
                    self?.errorTitle = "Error occurred"
                    self?.errorDescription = "An unexpected error occurred while trying to load the recipes, please try again"
                    
                    self?.showErrorStatus = true
                    
                    let logger = Logger.init(subsystem: "RecipeList", category: "RecipeListViewModel")
                    logger.error("Error retrieving recipes: \(err.errorDescription)")
                }
            } receiveValue: { [weak self] recipes in
                self?.recipes = recipes
                self?.notResults = recipes.isEmpty
                self?.isLoading = false
            }
            .store(in: &cancellable)
    }
}
