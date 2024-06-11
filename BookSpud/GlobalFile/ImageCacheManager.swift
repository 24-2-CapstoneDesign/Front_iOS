//
//  ImageCacheManager.swift
//  BookSpud
//
//  Created by 정의찬 on 6/9/24.
//

import Foundation
import SwiftUI

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    func loadImageData(from url: URL) -> Image? {
        return Icon.angrySpud.image
    }
    
    func downloadAndSaveImage(from url: URL) {
        print("hello")
    }
}
