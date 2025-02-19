//
//  RecipeCardView.swift
//  Recipes
//
//  Created by Gonzalo on 2/17/25.
//

import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe
    @State private var image: UIImage?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(15)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .cornerRadius(10)
                    .overlay(ProgressView())
            }
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 8)
        }
        .task(id: recipe.photoURLLarge) {
            await loadImage()
        }
    }

    private func loadImage() async {
        guard image == nil, let url = URL(string: recipe.photoURLLarge) else { return }
        do {
            image = try await ImageLoader.shared.loadImage(from: url)
        } catch {
            print("Failed to load image: \(error)")
        }
    }
}
