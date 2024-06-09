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
           print("hello")
        }
}
