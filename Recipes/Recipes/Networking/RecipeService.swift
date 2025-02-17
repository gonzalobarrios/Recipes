//
//  RecipeService.swift
//  Recipes
//
//  Created by Gonzalo on 2/15/25.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe]
}

class RecipeService: RecipeServiceProtocol {
    
    private let networkManager: NetworkManagerProtocol
    private let baseURL: URL

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared,
         baseURL: URL = APIConfiguration.baseURL) {
        self.networkManager = networkManager
        self.baseURL = baseURL
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        do {
            let recipes: Recipes = try await networkManager.performRequest(url: baseURL, method: .GET, body: nil)
            return recipes.recipes
        } catch let error as NetworkError {
            throw error
        } catch {
            throw error
        }
    }
}
