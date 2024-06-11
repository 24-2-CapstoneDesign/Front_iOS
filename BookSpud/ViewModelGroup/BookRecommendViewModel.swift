//
//  FriendConnectingLinkViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import Foundation
import Combine
import Moya
import SwiftUI

/// 추천책 뷰 전체 뷰모델
class BookRecommendViewModel: ObservableObject {
    @Published var bookRecommendData: BookRecommendData?
    private let provider: MoyaProvider<BookToBook>
    
    init(bookRecommendData: BookRecommendData? = nil,
         provider: MoyaProvider<BookToBook> = APIManager.shared.testProvider(for: BookToBook.self)
    ) {
        self.bookRecommendData = bookRecommendData
        self.provider = provider
    }
    
    
    public func getBookRecommend() {
        provider.request(.bookTobook) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleResponse(response: response)
            case .failure(let error):
                print("북 추천 네트워크 오류: \(error)")
            }
        }
    }
    
    private func handleResponse(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(BookRecommendData.self, from: response.data)
            bookRecommendData = decodedData
        } catch {
            bookRecommendData = nil
            print("북투북 추천 책 리스트 없음:  \(error)")
        }
    }
}
