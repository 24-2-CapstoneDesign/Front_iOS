//
//  ImageCacheManager.swift
//  BookSpud
//
//  Created by 정의찬 on 5/14/24.
//

import Foundation
import SwiftUI
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let cacheDirectory: URL
    
    init() {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = paths[0].appendingPathComponent("ImageCache")
        try? FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
    }
    
    private func cachePath(for url: URL) -> URL {
        return cacheDirectory.appendingPathComponent(url.lastPathComponent)
    }
    
    public func getImage(from url: URL) async -> UIImage? {
        let fileURL = cachePath(for: url)
        
        if let image = UIImage(contentsOfFile: fileURL.path(percentEncoded: true)) {
            return image
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            try data.write(to: fileURL, options: .atomic)
            return UIImage(data: data)
        } catch {
            print("image cacheLoad 오류 : \(error)")
            return nil
        }
    }
    
    public func saveImageToCache(image: UIImage, for url: URL) {
        let fileURL = cachePath(for: url)
        
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            do {
                try imageData.write(to: fileURL, options: .atomic)
            } catch {
                print("cache Image to URL: \(error)")
            }
        }
    }
}
