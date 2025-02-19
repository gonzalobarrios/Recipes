//
//  RecipesView.swift
//  Recipes
//
//  Created by Gonzalo on 2/15/25.
//

import SwiftUI

struct RecipesView: View {    
    @ObservedObject var viewModel = RecipesViewModel()
    @State var recipes: [Recipe] = []
    @State var selectedCuisine: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Recipes")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(viewModel.cuisines, id: \.self) { cuisine in
                        Button(action: {
                            if selectedCuisine == cuisine {
                                selectedCuisine = nil
                            } else {
                                selectedCuisine = cuisine == "All" ? nil : cuisine
                            }
                        }) {
                            Text(cuisine)
                                .font(.headline)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(selectedCuisine == cuisine ? Color.black : Color.gray.opacity(0.2))
                                .foregroundColor(selectedCuisine == cuisine ? Color.white : Color.black.opacity(0.7))
                                .clipShape(Capsule())
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(filteredRecipes) { recipe in
                        RecipeCardView(recipe: recipe)
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .refreshable {
                await viewModel.getRecipes()
            }
            .overlay {
                if viewModel.recipes.isEmpty {
                    Text("No Recipes Found")
                        .font(.largeTitle)
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                }
            }
            .alert(isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "An unknown error occurred."), dismissButton: .default(Text("OK")))
            }
            .task {
                await viewModel.getRecipes()
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.2), Color.yellow.opacity(0.5), Color.gray.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all))
    }
    
    var filteredRecipes: [Recipe] {
        if let cuisine = selectedCuisine {
            return viewModel.recipes.filter { $0.cuisine == cuisine }
        } else {
            return viewModel.recipes
        }
    }
}

#Preview {
    RecipesView()
}
