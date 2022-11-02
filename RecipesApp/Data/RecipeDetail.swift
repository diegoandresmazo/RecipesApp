//
//  RecipeDetail.swift
//  RecipesApp
//
//  Created by Diego Andres Mazo Munoz on 1/11/22.
//

import Foundation

public struct RecipeDetail: Decodable {
    let healthScore: Int
    let id: Int
    let title: String
    let readyInMinutes: Int
    let image: String
    let servings: Int
    let instructions: String
}
