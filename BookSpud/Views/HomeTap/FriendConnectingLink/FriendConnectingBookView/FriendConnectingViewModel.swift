//
//FriendConnectingViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import Foundation
import SwiftUI

/// 추천책 개개인 뷰모델
class FriendConnectingViewModel: ObservableObject {
    
    @Published var friendConnectingDetailData: FriendConnectingDetailData
    @Published var bookCover: SwiftUI.Image? = nil
    
    init(friendConnectingDetailData: FriendConnectingDetailData) {
        self.friendConnectingDetailData = friendConnectingDetailData
    }
    
    private var imageChache = ImageCacheManager.shared
    
    /// 이미지 데이터 캐시에 저장하기
    private func saveCache() {
        imageChache.downloadAndSaveImage(from: URL(string: friendConnectingDetailData.bookCoverUrl)!)
    }
    
    /// 이미지 데이터 캐시에서 로드하기
    private func loadCache() {
        guard let image = imageChache.loadImageData(from: URL(string: friendConnectingDetailData.bookCoverUrl)!) else { return }
        self.bookCover = image
    }
    
    /// 이미지 캐시 핸들러
    public func imageCacheHandler() {
        saveCache()
        loadCache()
    }
    
    
}
