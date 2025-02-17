//
//  RecipeServiceTests.swift
//  Recipes
//
//  Created by Gonzalo on 2/15/25.
//

import XCTest
@testable import Recipes

class RecipeServiceTests: XCTestCase {
    var sut: RecipeService!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        sut = RecipeService(networkManager: mockNetworkManager, baseURL: APIConfiguration.baseURL)
    }

    override func tearDown() {
        mockNetworkManager = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Fetch Recipes Tests
    
    func testFetchRecipesSuccess() async throws {
        let expectedRecipes: [Recipe] = [Recipe(uuid: "1", cuisine: "Japanese", name: "Sushi", photoURLLarge: "", photoURLSmall: "", sourceURL: nil, youtubeURL: nil),
                               Recipe(uuid: "2", cuisine: "Chinese", name: "Lo Mein", photoURLLarge: "", photoURLSmall: "", sourceURL: nil, youtubeURL: nil)]
        let result = Recipes(recipes: expectedRecipes)
        mockNetworkManager.mockResult(result)
        
        let recipes = try await sut.fetchRecipes()
        
        XCTAssertEqual(recipes.count, 2)
        XCTAssertEqual(recipes[0].cuisine, "Japanese")
        XCTAssertEqual(recipes[1].name, "Lo Mein")
    }
    
    func testFetchRecipesNetworkError() async throws {
        mockNetworkManager.mockError(NetworkError.invalidResponse(statusCode: 500))
        
        do {
            _ = try await sut.fetchRecipes()
            XCTFail( "Expected error to be thrown")
        } catch let error as NetworkError {
            XCTAssertEqual(error.localizedDescription, "Invalid Response from the server. Status code: 500")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
