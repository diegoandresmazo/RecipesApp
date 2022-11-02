//
//  RecipeCard.swift
//  RecipesApp
//
//  Created by Diego Andres Mazo Munoz on 31/10/22.
//

import Foundation
import SwiftUI

private struct Constants {
    static let imageHeight: CGFloat = 180
    static let imageOpacity: CGFloat = 0.6
    static let titleSize: CGFloat = 26.0
}

struct ProductCard: View {
    var imageURL: String
    var title: String
    
    var image: some View {
        AsyncImage(url: URL(string: imageURL)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            image
                .frame(height: Constants.imageHeight)
                .frame(maxWidth: .infinity)
                .opacity(Constants.imageOpacity)
            
            Text(title)
                .font(.system(size: Constants.titleSize, weight: .bold, design: .default))
                .foregroundColor(.white)
                .lineLimit(3)
                .minimumScaleFactor(0.7)
                .shadow(color: Color.black.opacity(1), radius: 10, x: 0, y: 0)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
        .roundCard()
    }
}
