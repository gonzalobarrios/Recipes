//
//  MockDiskCache.swift
//  Recipes
//
//  Created by Gonzalo on 2/19/25.
//

import UIKit
@testable import Recipes

class MockDiskCache: DiskCacheProtocol {
    var imageToReturnFromDisk: UIImage?
    var saveImageToDiskCalledWithImage: UIImage?
    var saveImageToDiskCalledWithURL: URL?

    func loadImageFromDisk(for url: URL) -> UIImage? {
        return imageToReturnFromDisk
    }

    func saveImageToDisk(_ image: UIImage, for url: URL) {
        saveImageToDiskCalledWithImage = image
        saveImageToDiskCalledWithURL = url
    }
}
