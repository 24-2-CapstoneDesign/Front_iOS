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
    @Published var individualBookData: IndividualBookData?
    @Published var emotionUserData: EmotionUserData?
    
    var mainBtnCliked: Bool
    var provider: MoyaProvider<BookRecommendDetailAPI>
    
    // MARK: - Init
    
    init(authorImage: SwiftUI.Image? = nil,
         individualBookData: IndividualBookData? = nil,
         emotionUserData: EmotionUserData? = nil,
         mainBtnCliked: Bool = true,
         provider: MoyaProvider<BookRecommendDetailAPI> = APIManager.shared.testProvider(for: BookRecommendDetailAPI.self)
    ) {
        self.authorImage = authorImage
        self.individualBookData = individualBookData
        self.emotionUserData = emotionUserData
        self.mainBtnCliked = mainBtnCliked
        self.provider = provider
    }
    
    // MARK: - API
    
    /// 책 상세 정보 받아오기
    /// - Parameter id: 책 아이디 값
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
    
    /// 책 상세 정보 받아오기 핸들 데이터
    /// - Parameter response: API 반응값
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
    
    
    /// 추천 책이 들고 있는 여러가지 북마크 데이터
    /// - Parameter id: 책 아이디
     public func getDataProfile(id: Int) {
         provider.request(.emotionBookMark(id: id)) { [weak self] result in
             switch result {
             case .success(let response):
                 self?.handleResponseProfile(response: response)
             case .failure(let error):
                 print("북투북 유저 북마크 받아오기 네트워크 오류 : \(error)")
             }
         }
     }
    
    
    /// 추천 책 북마크 받아오기 핸들 데이터
    /// - Parameter response: API 반응 값
    private func handleResponseProfile(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(EmotionUserData.self, from: response.data)
            self.emotionUserData = decodedData
            print("유저 북마크 받아오기 : \(decodedData)")
        } catch {
            print("유저 북마크 받아오기 디코더 오류 : \(error)")
        }
    }
}
