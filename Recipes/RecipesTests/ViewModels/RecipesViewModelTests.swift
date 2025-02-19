//
//  RecipesViewModelTests.swift
//  Recipes
//
//  Created by Gonzalo on 2/19/25.
//

import XCTest
@testable import Recipes

class RecipesViewModelTests: XCTestCase {
    
    class MockRecipeService: RecipeServiceProtocol {
        var shouldFail = false
        var mockRecipes: [Recipe] = []
        
        func fetchRecipes() async throws -> [Recipe] {
            if shouldFail {
                throw NetworkError.invalidResponse(statusCode: 404)
            }
            return mockRecipes
        }
    }
    
    var sut: RecipesViewModel!
    var mockService: MockRecipeService!
    
    @MainActor
    override func setUp() async throws {
        try await super.setUp()
        mockService = MockRecipeService()
        sut = RecipesViewModel(recipesService: mockService)
    }
    
    @MainActor
    override func tearDown() async throws {
        sut = nil
        mockService = nil
        try await super.tearDown()
    }
    
    func testInitialState() async throws {
        let recipes = await sut.recipes
        let isLoading = await sut.isLoading
        let errorMessage = await sut.errorMessage
        
        XCTAssertTrue(recipes.isEmpty)
        XCTAssertFalse(isLoading)
        XCTAssertNil(errorMessage)
    }
    
    func testGetRecipesSuccess() async throws {
        let mockRecipes = [
            Recipe(uuid: "1", cuisine: "Italian", name: "Pasta", photoURLLarge: "", photoURLSmall: "", sourceURL: nil, youtubeURL: nil),
            Recipe(uuid: "2", cuisine: "Japanese", name: "Sushi", photoURLLarge: "", photoURLSmall: "", sourceURL: nil, youtubeURL: nil)
        ]
        mockService.mockRecipes = mockRecipes

        await sut.getRecipes()

        let recipes = await sut.recipes
        let isLoading = await sut.isLoading
        let errorMessage = await sut.errorMessage
        
        XCTAssertTrue(recipes.count == mockRecipes.count)
        XCTAssertFalse(isLoading)
        XCTAssertNil(errorMessage)
    }
    
    func testGetRecipesFailure() async throws {
        mockService.shouldFail = true
        
        await sut.getRecipes()
        
        let recipes = await sut.recipes
        let isLoading = await sut.isLoading
        let errorMessage = await sut.errorMessage
        
        XCTAssertTrue(recipes.isEmpty)
        XCTAssertFalse(isLoading)
        XCTAssertNotNil(errorMessage)
    }
    
    func testCuisinesComputedProperty() async throws {
        let mockRecipes = [
            Recipe(uuid: "1", cuisine: "Italian", name: "Pasta", photoURLLarge: "", photoURLSmall: "", sourceURL: nil, youtubeURL: nil),
            Recipe(uuid: "2", cuisine: "Italian", name: "Pizza", photoURLLarge: "", photoURLSmall: "", sourceURL: nil, youtubeURL: nil),
            Recipe(uuid: "3", cuisine: "Japanese", name: "Sushi", photoURLLarge: "", photoURLSmall: "", sourceURL: nil, youtubeURL: nil)
        ]
        
        await MainActor.run {
            sut.recipes = mockRecipes
        }

        let cuisines = await sut.cuisines
        XCTAssertEqual(cuisines, ["All", "Italian", "Japanese"])
    }
}
