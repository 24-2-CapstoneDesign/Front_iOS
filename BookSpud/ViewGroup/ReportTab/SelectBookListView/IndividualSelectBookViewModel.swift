//
//  IndividualSelectBookViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import SwiftUI
import Combine

class IndividualSelectBookViewModel: ObservableObject {
    @Published var data: BookListDetailData
    @Published var bookCover: SwiftUI.Image?
    private var cancellable: AnyCancellable?
    
    init(data: BookListDetailData) {
        self.data = data
    }
    
    // MARK: - CacheImage
    
    /// 캐시된 이미지 불러오기
    /// - Parameter url: 이미지 키값 사용하기
    public func loadImage(from url: URL) {
        if let cachedImage = ImageCacheManager.shared.loadImageData(from: url) {
            self.bookCover = cachedImage
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
                    self.bookCover = Image(uiImage: uiImage)
                }
            })
    }
}
