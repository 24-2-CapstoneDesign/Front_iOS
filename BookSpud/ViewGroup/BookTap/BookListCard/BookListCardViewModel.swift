//
//  BookListCarViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/2/24.
//

import Foundation
import Combine
import SwiftUI

class BookListCardViewModel: ObservableObject {
    
    // MARK: - Property
    
    @Published var bookListDetailData: BookListDetailData
    @Published var authorImage: Image?
    
    private var cancellable: AnyCancellable?
    var imageCacheHandler = ImageCacheManager.shared
    
    // MARK: - Init
    
    init(bookListDetailData: BookListDetailData) {
        self.bookListDetailData = bookListDetailData
    }
    
    // MARK: - CacheImage
    
    func loadImage(from url: URL) {
            if let cachedImage = ImageService.shared.loadImage(from: url) {
                self.authorImage = cachedImage
            } else {
                cancellable = URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
                    .catch { _ in Just(Data()) }
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] data in
                        guard !data.isEmpty, let self = self, let uiImage = UIImage(data: data) else { return }
                        ImageService.shared.downloadImage(from: url) { image in
                            self.authorImage = image
                        }
                    })
            }
        }
}
