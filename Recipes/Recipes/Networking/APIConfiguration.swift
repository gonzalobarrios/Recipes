//
//  RecipeServiceConfiguration.swift
//  Recipes
//
//  Created by Gonzalo on 2/16/25.
//

import Foundation

enum APIEnvironment {
    case production
    case debug
    
    var baseURL: URL {
        switch self {
        case .production:
            return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        case .debug:
            return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        }
    }
}

struct APIConfiguration {
    #if DEBUG
    static let environment: APIEnvironment = .debug
    #else
    static let environment: APIEnvironment = .production
    #endif
    
    static var baseURL: URL {
        return environment.baseURL
    }
    
}


