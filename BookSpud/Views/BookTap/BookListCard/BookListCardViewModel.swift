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
    @Published var image: Image?
    
    private var cancellable: AnyCancellable?
    var imageCacheHandler = ImageCacheManager.shared
    
    // MARK: - Init
    
    init(bookListDetailData: BookListDetailData) {
        self.bookListDetailData = bookListDetailData
    }
    
    // MARK: - CacheImage
    
    /// 캐시된 이미지 불러오기
    /// - Parameter url: 이미지 키값 사용하기
    public func loadImage(from url: URL) {
        if let cachedImage = ImageCacheManager.shared.loadImageData(from: url) {
            self.image = cachedImage
        } else {
            downloadImage(from: url)
        }
    }
    
    /// 캐시된 이미지 없을 시 다운로드하기
    /// - Parameter url: 이미지 다운로드 주소
    private func downloadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .catch { _ in Just(Data()) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in}, receiveValue: { [weak self] data in
                guard !data.isEmpty, let self = self else { return }
                ImageCacheManager.shared.downloadAndSaveImage(from: url)
                if let uiImage = UIImage(data: data) {
                    self.image = Image(uiImage: uiImage)
                }
            })
    }
}
