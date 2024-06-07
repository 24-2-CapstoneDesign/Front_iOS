//
//  BookListViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import Foundation
import Combine
import Moya

class BookListViewModel: ObservableObject {
    @Published var bookListBookData: BookListBookData?
    private let imageCacheManager = ImageCacheManager.shared
    
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<BookListAPI>
    
    init() {
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<BookListAPI>(session: session)
    }
    
    
    public func getBookList() {
        provider.request(.bookListAPI) {[weak self] result in
            switch result {
            case .success(let response):
                self?.handleGetBook(response: response)
            case .failure(let error):
                print("네트워크 오류: \(error)")
            }
        }
    }
    
    private func handleGetBook(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(BookListBookData.self, from: response.data)
            self.bookListBookData = decodedData
        } catch {
            print("디코더 오류: \(error)")
        }
    }
}
