//
//  ImageLoaderTests.swift
//  Recipes
//
//  Created by Gonzalo on 2/19/25.
//

import XCTest
@testable import Recipes

class ImageLoaderTests: XCTestCase {
    
    var mockImageCache: MockImageCache!
    var mockImageFetcher: MockImageFetcher!
    var mockDiskCache: MockDiskCache!
    var imageLoader: ImageLoader!

    override func setUp() {
        super.setUp()
        
        mockImageCache = MockImageCache()
        mockImageFetcher = MockImageFetcher()
        mockDiskCache = MockDiskCache()
        imageLoader = ImageLoader(
            imageCache: mockImageCache,
            imageFetcher: mockImageFetcher,
            diskCache: mockDiskCache
        )
    }

    override func tearDown() {
        imageLoader = nil
        mockImageCache = nil
        mockImageFetcher = nil
        mockDiskCache = nil
        
        super.tearDown()
    }

    func testLoadImageFromCache() async throws {
        let testURL = URL(string: "https://example.com/test.jpg")!
        let cachedImage = UIImage()
        mockImageCache.imageToReturn = cachedImage

        let image = try await imageLoader.loadImage(from: testURL)

        XCTAssertEqual(image, cachedImage)
        XCTAssertEqual(mockImageCache.imageCalledWithURL, testURL)
    }

    func testLoadImageFromDisk() async throws {
        let testURL = URL(string: "https://example.com/test.jpg")!
        let diskImage = UIImage()
        mockDiskCache.imageToReturnFromDisk = diskImage

        let image = try await imageLoader.loadImage(from: testURL)

        XCTAssertEqual(image, diskImage)
        XCTAssertTrue(mockImageCache.insertCalledWithImage == diskImage)
    }

    func testLoadImageFromNetwork() async throws {
        let testURL = URL(string: "https://example.com/test.jpg")!
        let networkImage = UIImage()
        mockImageFetcher.imageToReturn = networkImage

        let image = try await imageLoader.loadImage(from: testURL)

        XCTAssertEqual(image, networkImage)
        XCTAssertTrue(mockImageFetcher.fetchImageCalledWithURL == testURL)
        XCTAssertTrue(mockImageCache.insertCalledWithImage == networkImage)
        XCTAssertTrue(mockDiskCache.saveImageToDiskCalledWithImage == networkImage)
    }

    func testImageFetcherThrowsError() async {
        let testURL = URL(string: "https://example.com/test.jpg")!
        mockImageFetcher.imageToReturn = nil

        do {
            _ = try await imageLoader.loadImage(from: testURL)
            XCTFail("Expected error but got image.")
        } catch let error as ImageLoaderError {
            XCTAssertEqual(error, ImageLoaderError.invalidImageData)
        } catch {
            XCTFail("Unexpected error type.")
        }
    }
}
