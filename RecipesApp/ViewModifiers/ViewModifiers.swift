//
//  ViewModifiers.swift
//  RecipesApp
//
//  Created by Diego Andres Mazo Munoz on 1/11/22.
//

import Foundation
import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}

struct ProgressViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .scaleEffect(1.4)
    }
}

extension View {
    func roundCard() -> some View {
        modifier(CardModifier())
    }
}

extension ProgressView {
    func defaultProgressView() -> some View {
        modifier(ProgressViewModifier())
    }
}
