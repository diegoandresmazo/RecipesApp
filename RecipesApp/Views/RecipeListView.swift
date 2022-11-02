//
//  RecipeListView.swift
//  RecipesApp
//
//  Created by Diego Andres Mazo Munoz on 31/10/22.
//

import SwiftUI

private struct Constants {
    static let errorIconSize: CGSize = CGSize(width: 100, height: 100)
    static let errorTitleSize: CGFloat = 26.0
    static let errorDescriptionSize: CGFloat = 16.0
    static let navigationTitle: String = "Recipes"
    static let searchBarPrompt: String = "Search by recipe name"
    static let progressViewTitle: String = "Loading..."
}

struct RecipeListView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = RecipeListViewModel()
    
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
        .onAppear(perform: {
            viewModel.recipes.removeAll()
        })
    }
    
    var body: some View {
        if viewModel.isLoading {
            if viewModel.showErrorStatus {
                errorView
            } else {
                ProgressView(Constants.progressViewTitle)
                    .defaultProgressView()
            }
        } else {
            NavigationView {
                if viewModel.notResults {
                    errorView
                        .navigationTitle(Constants.navigationTitle)
                } else {
                    List(viewModel.recipes, id: \.id) { recipe in
                        NavigationLink(destination: RecipeDetailView(viewModel: RecipeDetailViewModel(recipeId: recipe.id))) {
                            ProductCard(imageURL: recipe.image, title: recipe.title)
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                    }
                    .navigationTitle(Constants.navigationTitle)
                }
            }
            .searchable(text: $searchText, prompt: Constants.searchBarPrompt)
            .onSubmit(of: .search) {
                viewModel.search(name: searchText)
            }
        }
    }
}
