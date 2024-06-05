//
//FriendConnectingViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

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
    
    private var imageCache = ImageCacheManager.shared
    private var cancellable: AnyCancellable?
    
    private func downloadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .catch { _ in Just(Data()) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in}, receiveValue: {
                [weak self] data in
                guard !data.isEmpty, let self = self else { return }
                imageCache.downloadAndSaveImage(from: url)
                if let uiImage = UIImage(data: data) {
                    self.bookCover = Image(uiImage: uiImage)
                }
            })
    }
    
    public func loadImage(from url: URL) {
        if let cachedImage = imageCache.loadImageData(from: url) {
            self.bookCover = cachedImage
        } else {
            downloadImage(from: url)
        }
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
