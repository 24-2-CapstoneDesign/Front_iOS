//
//  ReportCardViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/5/24.
//

import Foundation
import SwiftUI
import Combine

class ReportCardViewModel: ObservableObject {
    @Published var bookCover: Image?
    
    let imageCache = ImageCacheManager.shared
    private var cancellable: AnyCancellable?
    
    
    public func loadImage(from url: URL) {
        if let cachedImage = imageCache.loadImageData(from: url) {
            self.bookCover = cachedImage
        } else {
            downloadImage(from: url)
        }
    }
    
    private func downloadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .catch { _ in Just(Data()) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in}, receiveValue: {
                [weak self] data in
                guard !data.isEmpty, let self = self else { return }
                imageCache.downloadAndSaveImage(from: url)
                if let uiImage = UIImage(data: data) {
                    self.bookCover = Image(uiImage: uiImage)
                }
            })
    }
    
}
