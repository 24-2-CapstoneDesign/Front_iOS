//
//  ImageService.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//
import SwiftUI



class ImageService {
    static let shared = ImageService()
    private var imageCache = ImageCacheManager.shared
    
    private init() {}
    
    func downloadImage(from url: URL, completion: @escaping (Image?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let uiImage = UIImage(data: data) else {
                completion(nil)
                return
            }
            self.imageCache.saveImageData(data, for: url)
            DispatchQueue.main.async {
                completion(Image(uiImage: uiImage))
            }
        }.resume()
    }
    
    func loadImage(from url: URL) -> Image? {
        return imageCache.loadImageData(from: url)
    }
}
