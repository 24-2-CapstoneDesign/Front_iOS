//
//  EmotionUserViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/27/24.
//

import Foundation
import SwiftUI

class EmotionUserViewModel: ObservableObject {
    
    @Published var emotionUserProfile: SwiftUI.Image = Icon.cutyPotato.image
    @Published var emotionUserDetailData: EmotionUserDetailData?
    var imageCacheHandler = ImageCacheManager.shared
    
    init(emotionUserDetailData: EmotionUserDetailData?) {
        self.emotionUserDetailData = emotionUserDetailData
    }
    
    /// 유저 프로필 캐시 저장
    /// - Parameter emotionUserDetailData: 유저 정보 담고 있는 데이터 정보
    private func userProfileSave(_ emotionUserDetailData: EmotionUserDetailData) {
        imageCacheHandler.downloadAndSaveImage(from: URL(string: emotionUserDetailData.bookMarkProfile)!)
    }
    
    /// 유저 프로필 로드
    /// - Parameter emotionUserDetailData: 유저 정보 담고 있는 데이터 정보
    private func userProfileLoad(_ emotionUserDetailData: EmotionUserDetailData) {
        guard let cacheImage = imageCacheHandler.loadImageData(from: URL(string: emotionUserDetailData.bookMarkProfile)!) else { return }
        self.emotionUserProfile = cacheImage
    }
    
    /// 유저 닉네임 및 프로필 사진 업데이트
    public func userDataInfoUpdate() {
        guard let emotionUserDetailData = emotionUserDetailData else { return }
        self.userProfileSave(emotionUserDetailData)
        self.userProfileLoad(emotionUserDetailData)
    }
}
