//
//FriendConnectingViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import Foundation
import SwiftUI
import Combine
import Moya

/// 추천책 개개인 뷰모델
class BookRecommendCardViewModel: ObservableObject {
    
    @Published var authorImage: SwiftUI.Image?
    @Published var bookRecommendDetailData: BookRecommendDetailData
    @Published var individualBookData: IndividualBookData? = nil
    @Published var emotionUserData: EmotionUserData?
    @Published var bookCover: SwiftUI.Image? = nil
    var mainBtnCliked: Bool = true
    
    // MARK: - Init
    init(bookRecommendDetailData: BookRecommendDetailData) {
        self.bookRecommendDetailData = bookRecommendDetailData
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<BookToBook>(session: session)
        userProvider = MoyaProvider<EmotionUserAPI>(session: session)
    }
    
    // MARK: - API Property
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<BookToBook>
    var userProvider: MoyaProvider<EmotionUserAPI>
    
    // MARK: - Book Recommend Individual Function
    
    private var imageCache = ImageCacheManager.shared
    private var cancellable: AnyCancellable?

    
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

    
    // MARK: - API
    
    public func getDetailBookInfo(id: Int) {
        provider.request(.detailBookInfo(id: id)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleResponse(response: response)
            case .failure(let error):
                print("북 상세 정보 네트워크 오류: \(error)")
            }
        }
    }
    
    private func handleResponse(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(IndividualBookData.self, from: response.data)
            individualBookData = decodedData
        } catch {
            print("북 상세 정보 디코디드 오류: \(error)")
        }
    }

    
    // MARK: - Book Recommend DetailView Function
    
    /// 책 구매 사이트로 연결
    public func purchaseBook() {
        if let urlString = self.individualBookData?.result.purchaseLink,
           let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("구매 링크 연결 x")
        }
    }
    
    
     public func getDataProfile(id: Int) {
         userProvider.request(.emotionBookMark(id: id)) { [weak self] result in
             switch result {
             case .success(let response):
                 do {
                     let decodedData = try JSONDecoder().decode(EmotionUserData.self, from: response.data)
                     self?.emotionUserData = decodedData
                     print("유저 북마크 받아오기 : \(decodedData)")
                 } catch {
                     print("유저 북마크 받아오기 디코더 오류 : \(error)")
                 }
             case .failure(let error):
                 print("유저 받아오기 네트워크 오류: \(error)")
             }
         }
                
     }
}
