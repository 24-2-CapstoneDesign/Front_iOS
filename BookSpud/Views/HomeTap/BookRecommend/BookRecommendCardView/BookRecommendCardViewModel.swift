//
//FriendConnectingViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import Foundation
import SwiftUI

/// 추천책 개개인 뷰모델
class BookRecommendCardViewModel: ObservableObject {
    
    @Published var bookRecommendDetailData: BookRecommendDetailData
    @Published var emotionUserData: EmotionUserData?
     = EmotionUserData(information: [
        EmotionUserDetailData(bookMarkProfile: "https://images.kbench.com/kbench/article/2015_05/k150016p1n17.jpg", bookMarkName: "정문에 주먹"),
        EmotionUserDetailData(bookMarkProfile: "https://i.namu.wiki/i/sDpa4ff-basni7Hfapgtafw_zilZi08zSil9fWX1GZAykXRgYOmYW5larG-tF5ezrfC296MvOAxS5r6Ti-X5eDhbwfI9F8E-BEwfs0vaCvQW-FWz7Fu013nOBKKL4lcl1LkgHY-VuoBFBktlglCoog.webp", bookMarkName: "뽀로로"),
        EmotionUserDetailData(bookMarkProfile: "http://tnnews.co.kr/wp-content/uploads/2021/09/사진설명_와디즈-팬즈메이커로-진로-두꺼비-제품-만든다0.jpg", bookMarkName: "두껍 왕자"),
        EmotionUserDetailData(bookMarkProfile: "https://www.cau.ac.kr/cau/img/campusinfo/mascot-tab1_01.jpg", bookMarkName: "푸앙이"),
        EmotionUserDetailData(bookMarkProfile: "https://velog.velcdn.com/images/leewoojye/post/1dc6dc4d-5120-4743-9837-f4d0904c7a7e/image.png", bookMarkName: "유엠씨"),
     ])
    @Published var bookCover: SwiftUI.Image? = nil
    var mainBtnCliked: Bool = true
    
    // MARK: - Init
    init(bookRecommendDetailData: BookRecommendDetailData) {
        self.bookRecommendDetailData = bookRecommendDetailData
    }
    
    // MARK: - Book Recommend Individual Function
    
    private var imageChache = ImageCacheManager.shared
    
    /// 이미지 데이터 캐시에 저장하기
    private func saveCache() {
        imageChache.downloadAndSaveImage(from: URL(string: bookRecommendDetailData.bookCoverUrl)!)
    }
    
    /// 이미지 데이터 캐시에서 로드하기
    private func loadCache() {
        guard let image = imageChache.loadImageData(from: URL(string: bookRecommendDetailData.bookCoverUrl)!) else { return self.bookCover = nil }
        self.bookCover = image
    }
    
    
    //TODO: - 로드 방식 바꾸기
    /// 이미지 캐시 핸들러
    public func imageCacheHandler() {
        saveCache()
        loadCache()
    }
    
    // MARK: - Book Recommend DetailView Function
    
    /// 책 구매 사이트로 연결
    public func purchaseBook() {
        if let url = URL(string: self.bookRecommendDetailData.purchaseURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            print("클릭 주소 : \(url)")
        } else {
            print(self.bookRecommendDetailData.purchaseURL)
        }
    }
}
