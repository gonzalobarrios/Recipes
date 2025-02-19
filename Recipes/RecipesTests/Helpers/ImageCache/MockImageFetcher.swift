//
//  MockImageFetcher.swift
//  Recipes
//
//  Created by Gonzalo on 2/19/25.
//

import UIKit
@testable import Recipes

class MockImageFetcher: ImageFetcherProtocol {
    var imageToReturn: UIImage?
    var fetchImageCalledWithURL: URL?

    func fetchImage(from url: URL) async throws -> UIImage {
        fetchImageCalledWithURL = url
        guard let image = imageToReturn else {
            throw ImageLoaderError.invalidImageData
        }
        return image
    }
}
