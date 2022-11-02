//
//  RecipeDetail.swift
//  RecipesApp
//
//  Created by Diego Andres Mazo Munoz on 1/11/22.
//

import SwiftUI

private struct Constants {
    static let errorIconSize: CGSize = CGSize(width: 100, height: 100)
    static let errorTitleSize: CGFloat = 26.0
    static let errorDescriptionSize: CGFloat = 16.0
    static let progressViewTitle: String = "Loading..."
    static let recipeImageHeight: CGFloat = 240
    static let recipeTitleSize: CGFloat = 26.0
    static let recipeReadyInMinutesSize: CGFloat = 20.0
    static let recipeServingsSize: CGFloat = 20.0
    static let recipeHealthScoreSize: CGFloat = 22.0
    static let recipeInstructionsTextSize: CGFloat = 18.0
}

struct RecipeDetailView: View {
    @StateObject var viewModel: RecipeDetailViewModel
    
    var image: some View {
        AsyncImage(url: URL(string: viewModel.recipeDetail?.image ?? "")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
                .defaultProgressView()
        }
    }
    
    private var errorView: some View {
        VStack(spacing: 12) {
            Image(systemName: viewModel.errorIcon)
                .font(.system(size: 100))
                .foregroundColor(Color(.black))
                .frame(width: Constants.errorIconSize.width, height: Constants.errorIconSize.height)
            
            Text(viewModel.errorTitle)
                .font(.system(size: Constants.errorTitleSize, weight: .bold, design: .default))
                .foregroundColor(.black)
            
            Text(viewModel.errorDescription)
                .font(.system(size: Constants.errorDescriptionSize, weight: .regular, design: .default))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 24)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                if viewModel.showErrorStatus {
                    errorView
                } else {
                    ProgressView(Constants.progressViewTitle)
                        .defaultProgressView()
                }
            } else {
                image
                    .frame(height: Constants.recipeImageHeight)
                    .frame(maxWidth: .infinity)
                
                VStack {
                    Text(viewModel.recipeDetail?.title ?? "")
                        .font(.system(size: Constants.recipeTitleSize, weight: .semibold, design: .default))
                        .foregroundColor(.black)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.8)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                }
                .background(Color.green.opacity(0.9))
                .padding(.bottom, 10)
                
                VStack {
                    Text("\(String(viewModel.recipeDetail?.readyInMinutes ?? 0)) mins prep time")
                        .font(.system(size: Constants.recipeReadyInMinutesSize, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .multilineTextAlignment(.center)
                    
                    Text("\(String(viewModel.recipeDetail?.servings ?? 0)) servings")
                        .font(.system(size: Constants.recipeServingsSize, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .multilineTextAlignment(.center)
                    
                    Label(String(viewModel.recipeDetail?.healthScore ?? 0), systemImage: Icons.System.scoreFoodIcon)
                        .foregroundColor(.green)
                        .font(.system(size: Constants.recipeHealthScoreSize, weight: .semibold, design: .default))
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                
                VStack {
                    Text(viewModel.recipeDetail?.instructions ?? "")
                        .font(.system(size: Constants.recipeInstructionsTextSize, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .minimumScaleFactor(0.8)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                        .background(Color.green.opacity(0.2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                .padding(.horizontal, 10)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            viewModel.getRecipeDetail()
        })
    }
}
