//
//  Error+Networking.swift
//  RecipesApp
//
//  Created by Diego Andres Mazo Munoz on 31/10/22.
//

import Foundation

public enum CloudError: Error {
    case decode(error: Error)
    case server(error: Error)
    
    public var errorDescription: String {
        switch self {
        case .decode(let error):
            return "Unable to parse JSON, error: \(error)"
        case .server(let error):
            return "API Server error: \(error)"
        }
    }
}
