//
//  ContentView.swift
//  Recipes
//
//  Created by Gonzalo on 2/15/25.
//

import SwiftUI

struct RecipesView: View {    
    @ObservedObject var viewModel = RecipesViewModel()
    
    var body: some View {
        Text("Recipes")
        List(viewModel.recipes, id: \.id) { recipe in
            Text(recipe.name)
        }
        .overlay {
            if viewModel.emptyList {
                Text("No Recipes Found")
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
}

#Preview {
    RecipesView()
}
