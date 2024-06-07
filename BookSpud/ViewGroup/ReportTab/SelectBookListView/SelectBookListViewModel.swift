//
//  SelectBookListViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/5/24.
//

import Foundation
import SwiftUI
import Combine
import Moya

class SelectBookListViewModel: ObservableObject {
    
    @Published var bookListBookData: BookListBookData?
    @Published var bookCover: SwiftUI.Image?
    let imageCache = ImageCacheManager.shared
    private var cancellable: AnyCancellable?
    
    
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<SelectBookListAPI>
    
    init() {
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<SelectBookListAPI>(session: session)
    }
    
    
    public func loadImage(from url: URL) {
        if let cacheImage = imageCache.loadImageData(from: url) {
            self.bookCover = cacheImage
        } 
    }
    
    private func downloadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .catch { _ in Just(Data())}
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in}, receiveValue: {
                [weak self] data in
                guard !data.isEmpty, let self = self else { return }
                imageCache.downloadAndSaveImage(from: url)
                if let uiImage = UIImage(data: data) {
                    self.bookCover = Image(uiImage: uiImage)
                }
            })
    }
    
    public func getBookList() {
        provider.request(.getBookList) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(BookListBookData.self, from: response.data)
                    self?.bookListBookData = decodedData
                } catch {
                    print("독후감 책 조회 디코드 오류: \(error)")
                }
            case .failure(let error):
                print("독후감 책 조회 네트워크 오류 : \(error)")
            }
        }
    }
}
