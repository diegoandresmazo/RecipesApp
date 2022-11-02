//
//  Recipe.swift
//  RecipesApp
//
//  Created by Diego Andres Mazo Munoz on 31/10/22.
//

import Foundation

public struct RecipeResponse: Decodable {
    let recipes: [Recipe]
    
    private enum CodingKeys: String, CodingKey {
        case recipes = "results"
    }
}

public struct Recipe: Decodable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        case imageType
    }
}
