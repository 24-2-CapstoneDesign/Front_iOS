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
//     = EmotionUserData(information: [
//        EmotionUserDetailData(bookMarkProfile: "https://i.namu.wiki/i/lFQp5iA6G_3iaFhP3HLa7HSMc-KAqw8KgQHlbgoJ9AvECILvQrkE6_Qj6VJWioWcX-7ARDubNiog1hNcZRnyCyNi9_A0qaZEwLde5xcMbGuqPpc6eXQJ9tC6I3Zq_U_fFuJ78V61TVkhRItfoclgNw.webp", bookMarkName: "뽀로로"),
//        EmotionUserDetailData(bookMarkProfile: "https://i.namu.wiki/i/lFQp5iA6G_3iaFhP3HLa7HSMc-KAqw8KgQHlbgoJ9AvECILvQrkE6_Qj6VJWioWcX-7ARDubNiog1hNcZRnyCyNi9_A0qaZEwLde5xcMbGuqPpc6eXQJ9tC6I3Zq_U_fFuJ78V61TVkhRItfoclgNw.webp", bookMarkName: "뽀로"),
//        EmotionUserDetailData(bookMarkProfile: "https://i.namu.wiki/i/lFQp5iA6G_3iaFhP3HLa7HSMc-KAqw8KgQHlbgoJ9AvECILvQrkE6_Qj6VJWioWcX-7ARDubNiog1hNcZRnyCyNi9_A0qaZEwLde5xcMbGuqPpc6eXQJ9tC6I3Zq_U_fFuJ78V61TVkhRItfoclgNw.webp", bookMarkName: "뽀로노"),
//        EmotionUserDetailData(bookMarkProfile: "https://i.namu.wiki/i/lFQp5iA6G_3iaFhP3HLa7HSMc-KAqw8KgQHlbgoJ9AvECILvQrkE6_Qj6VJWioWcX-7ARDubNiog1hNcZRnyCyNi9_A0qaZEwLde5xcMbGuqPpc6eXQJ9tC6I3Zq_U_fFuJ78V61TVkhRItfoclgNw.webp", bookMarkName: "뽀로트"),
//        EmotionUserDetailData(bookMarkProfile: "https://i.namu.wiki/i/lFQp5iA6G_3iaFhP3HLa7HSMc-KAqw8KgQHlbgoJ9AvECILvQrkE6_Qj6VJWioWcX-7ARDubNiog1hNcZRnyCyNi9_A0qaZEwLde5xcMbGuqPpc6eXQJ9tC6I3Zq_U_fFuJ78V61TVkhRItfoclgNw.webp", bookMarkName: "뽀로비"),
//        EmotionUserDetailData(bookMarkProfile: "https://i.namu.wiki/i/lFQp5iA6G_3iaFhP3HLa7HSMc-KAqw8KgQHlbgoJ9AvECILvQrkE6_Qj6VJWioWcX-7ARDubNiog1hNcZRnyCyNi9_A0qaZEwLde5xcMbGuqPpc6eXQJ9tC6I3Zq_U_fFuJ78V61TVkhRItfoclgNw.webp", bookMarkName: "뽀로키"),
//        EmotionUserDetailData(bookMarkProfile: "https://i.namu.wiki/i/lFQp5iA6G_3iaFhP3HLa7HSMc-KAqw8KgQHlbgoJ9AvECILvQrkE6_Qj6VJWioWcX-7ARDubNiog1hNcZRnyCyNi9_A0qaZEwLde5xcMbGuqPpc6eXQJ9tC6I3Zq_U_fFuJ78V61TVkhRItfoclgNw.webp", bookMarkName: "뽀로키니")
//     ])
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
        guard let image = imageChache.loadImageData(from: URL(string: bookRecommendDetailData.bookCoverUrl)!) else { return }
        self.bookCover = image
    }
    
    /// 이미지 캐시 핸들러
    public func imageCacheHandler() {
        saveCache()
        loadCache()
    }
    
    // MARK: - Book Recommend DetailView Function
    
    public func puerchaseBook() {
        print("책 구입")
    }
    
}
