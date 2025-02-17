//
//  MockNetworkManager.swift
//  Recipes
//
//  Created by Gonzalo on 2/16/25.
//

import Foundation
@testable import Recipes

class MockNetworkManager: NetworkManagerProtocol {
    private var result: Any?
    private var error: Error?
    
    func performRequest<T: Decodable>(url: URL, method: HTTPMethod, body: Data?) async throws -> T where T: Codable {
        if let error = error {
            throw error
        }
        
        guard let result = result as? T else {
            throw NetworkError.requestFailed(NSError(domain: "", code: -1))
        }
        
        return result
    }
    
    func mockResult<T: Codable>(_ value: T) {
        self.result = value
        self.error = nil
    }
    
    func mockError(_ error: Error) {
        self.error = error
        self.result = nil
    }
}
