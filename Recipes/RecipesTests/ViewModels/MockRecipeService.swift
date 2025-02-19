//
//  MockRecipeService.swift
//  Recipes
//
//  Created by Gonzalo on 2/19/25.
//

import XCTest
@testable import Recipes

@MainActor
class MockRecipeService: RecipeServiceProtocol {
    var shouldThrowError = false
    var mockRecipes: [Recipe] = [
        Recipe(uuid: "1", cuisine: "Italian", name: "Pasta", photoURLLarge: "", photoURLSmall: "", sourceURL: nil, youtubeURL: nil),
        Recipe(uuid: "2", cuisine: "Japanese", name: "Sushi", photoURLLarge: "", photoURLSmall: "", sourceURL: nil, youtubeURL: nil)
    ]

    func fetchRecipes() async throws -> [Recipe] {
        if shouldThrowError {
            throw NetworkError.invalidResponse(statusCode: 404)
        }
        return mockRecipes
    }
}
