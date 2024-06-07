//
//  ImageCacheManager.swift
//  BookSpud
//
//  Created by 정의찬 on 5/14/24.
//

import Foundation
import SwiftUI

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
    
    
    /// 이미지 캐시로 불러오기
    /// - Parameter url: 저장하고자 하는 Image URL 압력하기
    /// - Returns: Image 값 리턴하기
    public func loadImageData(from url: URL) -> Image? {
        let fileURL = cachePath(for: url)
        if let imageData = try? Data(contentsOf: fileURL),
           let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        }
        return nil
    }
    
    /// 이미지 데이터 저장하기
    /// - Parameters:
    ///   - data: 이미지 파일을 메모리에서 관리하기 위해 데이터 타입으로 저장
    ///   - url: 이미지가 저장되는 url 주소
    public func saveImageData(_ data: Data, for url: URL) {
        let fileURL = cachePath(for: url)
        do {
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("image data: \(error)")
        }
    }
    
    /// 이미지 데이터 url로부터 다운받아 데이터로 저장
    /// - Parameter url: 이미지 데이터의 저장 위치
    public func downloadAndSaveImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("URL error: \(error?.localizedDescription ?? "No error")")
                return
            }
            
            self?.saveImageData(data, for: url)
        }.resume()
    }
    
    
}
