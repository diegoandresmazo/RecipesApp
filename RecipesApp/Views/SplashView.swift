//
//  SplashView.swift
//  RecipesApp
//
//  Created by Diego Andres Mazo Munoz on 31/10/22.
//

import SwiftUI

private struct Constants {
    static let logoSize: CGSize = CGSize(width: 140, height: 140)
    static let splashDuration: Double = 3.0
}

struct SplashView: View {    
    @State private var isActive = false
    @State private var size = 0.6
    @State private var opacity = 0.4
    
    var body: some View {
        if isActive {
            RecipeListView()
        } else {
            VStack{
                VStack(spacing: 24) {
                    Image("logo")
                        .resizable()
                        .frame(width: Constants.logoSize.width, height: Constants.logoSize.height)
                    Text("The only food APP you'll ever need")
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(.black.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 24)
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 2.0)) {
                        self.size = 1
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.splashDuration) {
                    self.isActive = true
                }
            }
        }
    }
}
