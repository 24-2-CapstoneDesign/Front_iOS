//
//  BookDetailViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import Foundation
import SwiftUI
import Moya

class BookDetailViewModel: ObservableObject {
    @Published var bookListDetailData: BookListDetailData
    @Published var bookMarkData: BookMarkData?
    @Published var bookCoverImage: SwiftUI.Image?
    @Published var currentPage: Int = 0
    @Published var totalPage: Int = 0
    @Published var emotionImg: SwiftUI.Image = Icon.happySpud.image
    @Published var emotionTextImg: SwiftUI.Image = Icon.happyEmotion.image
    @Published var nickname: String = ""
    
    @Published var verses: String = ""
    @Published var memo: String = ""
    @Published var page: Int = 0
    @Published var emotion: String = ""
    var imageCacheManager = ImageCacheManager.shared
    
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<BookListDetailAPI>
    
    // MARK: - Init
    
    init(bookListDetailData: BookListDetailData) {
        self.bookListDetailData = bookListDetailData
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<BookListDetailAPI>(session: session)
    }
    
    // MARK: - Function
    
    public func loadSession() {
        if let user = KeyChainManager.standard.loadSession(for: "userSession"),
           let name = user.nickname {
            self.nickname = name
        }
    }
    
    /// 클릭해서 불러온 이미지 가져오기
    public func loadImage() {
        let urlString = bookListDetailData.cover
        if let url = URL(string: urlString) {
            if let image = imageCacheManager.loadImageData(from: url) {
                self.bookCoverImage = image
            }
        }
    }
    
    public func getBookMark(id: Int) {
        provider.request(.getBookMark(id: id)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(BookMarkData.self, from: response.data)
                    self?.bookMarkData = decodedData
                } catch {
                    print("북마크 디코더 에러: \(error)")
                }
            case .failure(let error):
                print("북마크 조회 에러: \(error)")
            }
        }
    }
    
    public func patchPage(id: Int, total: Int, final: Int) {
        provider.request(.pageUpdagte(id: id, total: total, final: final)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(BookPageData.self, from: response.data)
                    print("페이지 업데이트 완료")
                } catch {
                    print("페이지 디코드 \(error)")
                }
            case .failure(let error):
                print("네트웤 에러: \(error)")
            }
        }
    }
    
    public func emotionImageChange(_ emotion: String) {
        switch emotion {
        case "JOY":
            self.emotionTextImg = Icon.happyEmotion.image
            self.emotionImg = Icon.happySpud.image
        case "SADNESS":
            self.emotionTextImg = Icon.sadEmotion.image
            self.emotionImg = Icon.sadSpud.image
        case "ANGER":
            self.emotionTextImg = Icon.angryEmotion.image
            self.emotionImg = Icon.angrySpud.image
        case "INSPIRATION":
            self.emotionTextImg = Icon.inspirationEmotion.image
            self.emotionImg = Icon.inspirationSpud.image
        case "MOVED":
            self.emotionTextImg = Icon.moveEmotion.image
            self.emotionImg = Icon.sensationSpud.image
        default:
            break
        }
    }

}
