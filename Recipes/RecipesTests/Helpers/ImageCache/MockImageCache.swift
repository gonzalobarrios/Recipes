//
//  MockImageCache.swift
//  Recipes
//
//  Created by Gonzalo on 2/19/25.
//

import UIKit
@testable import Recipes

class MockImageCache: ImageCacheProtocol {
    var imageToReturn: UIImage?
    var insertCalledWithImage: UIImage?
    var insertCalledWithURL: URL?
    var imageCalledWithURL: URL?

    func image(for url: URL) -> UIImage? {
        imageCalledWithURL = url
        return imageToReturn
    }

    func insert(_ image: UIImage, for url: URL) {
        insertCalledWithImage = image
        insertCalledWithURL = url
    }
}

