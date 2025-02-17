//
//  RecipesViewModel.swift
//  Recipes
//
//  Created by Gonzalo on 2/15/25.
//

import Foundation

@MainActor
class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var emptyList: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let recipesService: RecipeServiceProtocol
    
    init(recipesService: RecipeServiceProtocol = RecipeService()) {
        self.recipesService = recipesService
    }
    
    func getRecipes() async {
        isLoading = true
        
        Task {
            do {
                recipes = try await recipesService.fetchRecipes()
            } catch let error as NetworkError {
                errorMessage = error.localizedDescription
            } catch {
                errorMessage = "An unknown error occurred."
            }
            isLoading = false
        }
    }
    
}
