//
//  NetworkManagerTests.swift
//  Recipes
//
//  Created by Gonzalo on 2/15/25.
//

@testable import Recipes
import XCTest

class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!
    var session: URLSession!
    let baseURL = URL(string: "https://example.com")!

    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: configuration)
        sut = NetworkManager(session: session)
    }

    override func tearDown() {
        MockURLProtocol.requestHandler = nil
        session = nil
        sut = nil
        super.tearDown()
    }

    func testPerformRequest_Success() async throws {
        let expectedData = """
        {
            "id": 1,
            "name": "sushi",
            "cuisine": "Japanese"
        }
        """.data(using: .utf8)!
        
        
        mockSuccessResponse(data: expectedData, statusCode: 200)
        
        let result: TestRecipe = try await sut.performRequest(url: baseURL, method: .GET)

        XCTAssertEqual(result.name, "sushi")
        XCTAssertEqual(result.cuisine, "Japanese")
    }
    
    func testPerformRequestError() async {
        mockErrorResponse(statusCode: 500, data: nil)
        
        do {
            let _: TestRecipe = try await sut.performRequest(url: baseURL, method: .GET)
            XCTFail("Expected error")
        } catch NetworkError.invalidResponse(let statusCode) {
            XCTAssertEqual(statusCode, 500)
        } catch {
            XCTFail("Unexpecte error: \(error)")
        }
    }
    
    func testDecodingError() async {
        let invalidData = "invalid json".data(using: .utf8)!
        mockSuccessResponse(data: invalidData, statusCode: 200)
        
        do {
            let _: TestRecipe = try await sut.performRequest(url: baseURL, method: .GET)
            XCTFail("Expected error")
        } catch NetworkError.decodingError {
            XCTAssert(true)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    private func mockErrorResponse(statusCode: Int, data: Data? = nil) {
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(url: self.baseURL, statusCode: statusCode, httpVersion: nil, headerFields: nil )!, data ?? Data())
        }
    }
    
    private func mockSuccessResponse(data: Data, statusCode: Int, requestInspector: ((URLRequest) -> Void)? = nil) {
        MockURLProtocol.requestHandler = { request in
            requestInspector?(request)
            return (HTTPURLResponse(url: self.baseURL, statusCode: statusCode, httpVersion: nil, headerFields: nil )!, data)
        }
    }
}

struct TestRecipe: Codable, Equatable {
    let id: Int
    let name: String
    let cuisine: String
}


