//
//  BookDetailViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import Foundation
import SwiftUI


class BookDetailViewModel: ObservableObject {
    @Published var bookListDetailData: BookListDetailData
    @Published var bookCoverImage: SwiftUI.Image?
    var imageCacheManager = ImageCacheManager.shared
    
    // MARK: - Init
    
    init(bookListDetailData: BookListDetailData) {
        self.bookListDetailData = bookListDetailData
    }
    
    // MARK: - Function
    
    /// 클릭해서 불러온 이미지 가져오기
    public func loadImage() {
        let urlString = bookListDetailData.bookCover
        if let url = URL(string: urlString) {
            if let image = imageCacheManager.loadImageData(from: url) {
                self.bookCoverImage = image
            }
        }
    }

}
