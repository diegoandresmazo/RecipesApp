//
//  RecipeDetailViewModel.swift
//  RecipesApp
//
//  Created by Diego Andres Mazo Munoz on 1/11/22.
//

import Foundation
import Combine
import OSLog

final class RecipeDetailViewModel: ObservableObject {
    private let recipeDetailService: RecipeDetailService
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published var recipeDetail: RecipeDetail?
    @Published var isLoading: Bool = true
    @Published var showErrorStatus: Bool = false
    
    var id: Int
    var errorIcon: String = Icons.System.errorIcon
    var errorTitle: String = "Error occurred"
    var errorDescription: String = "An unexpected error occurred while trying to load the recipe, please try again"

    init(recipeDetailService: RecipeDetailService = RecipeDetailService(), recipeId: Int) {
        self.recipeDetailService = recipeDetailService
        self.id = recipeId
    }
    
    func getRecipeDetail() {
        recipeDetailService.getRecipe(from: id)
            .sink { [weak self] errorCompletion in
                if case .failure(let err) = errorCompletion {
                    self?.showErrorStatus = true
                    
                    let logger = Logger.init(subsystem: "RecipeDetail", category: "RecipeDetailViewModel")
                    logger.error("Error retrieving recipe Detail: \(err.errorDescription)")
                }
            } receiveValue: { [weak self] recipe in
                self?.recipeDetail = recipe
                self?.isLoading = false
            }
            .store(in: &cancellable)
    }
}
