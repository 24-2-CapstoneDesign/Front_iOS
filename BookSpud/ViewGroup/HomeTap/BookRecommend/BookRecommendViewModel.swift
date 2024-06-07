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
    @Published var bookCover: SwiftUI.Image?
    private var cancellable: AnyCancellable?
    
    init(bookRecommendData: BookRecommendData? = nil) {
        self.bookRecommendData = bookRecommendData
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<BookToBook>(session: session)
    }
    
    // MARK: - API Property
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<BookToBook>
    
    // MARK: - CacheImage
    
    func loadImage(from url: URL) {
           if let cachedImage = ImageService.shared.loadImage(from: url) {
               self.bookCover = cachedImage
           } else {
               cancellable = URLSession.shared.dataTaskPublisher(for: url)
                   .map { $0.data }
                   .catch { _ in Just(Data()) }
                   .receive(on: DispatchQueue.main)
                   .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] data in
                       guard !data.isEmpty, let self = self, let uiImage = UIImage(data: data) else { return }
                       ImageService.shared.downloadImage(from: url) { image in
                           self.bookCover = image
                       }
                   })
           }
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
            print("북 추천 디코디드 오류: \(error)")
        }
    }
}
