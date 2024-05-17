//
//  TopUserViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/17/24.
//

import Foundation
import SwiftUI

class TopUserViewModel: ObservableObject {
    
    // MARK: - Propery
    
    /* TopUserInfo Property */
    @Published var userNickname: String = ""
    @Published var userProfileImage: SwiftUI.Image = Icon.cutyPotato.image
    
    /* Manager Property */
    private let keyChainManager = KeyChainManager.standard
    private let imageCacheManager = ImageCacheManager.shared
    
    
    /// 유저 정보 가져오기
    public func getUserData() {
        
        /* 삭제 요소 */
        
        var userInfo = UserInfo(nickname: "하하호호", profileImageURL: "https://i.namu.wiki/i/pQHsfzO5ctMKpI86mCqcfMTgqhVhfftCHhey-MgIiONYLDQVAWrCTCz_uLM4kRLYnagCOoMgZaA0MZ0ApSrarrWavNTzDcMdDRJahxCiWdqlP1vpEVVJxGg5EBDK0_X9jNR0a3hcldWVvcWz2ediUA.webp")
        
        keyChainManager.saveSession(userInfo, for: "userSession")
        var userInfo1 = keyChainManager.loadSession(for: "userSession")
        imageCacheManager.downloadAndSaveImage(from: URL(string: userInfo1?.profileImageURL ?? "")!)
        
        /* 여기서부터 보존하기 */
        
        guard let userInfo = keyChainManager.loadSession(for: "userSession"),
              let userImageUrl = userInfo.profileImageURL,
              let userNickname = userInfo.nickname
        else {
            print("userSession 저장된 값 없음 ")
            return
        }
        
        self.userNickname = userNickname
        self.userProfileImage = imageCacheManager.loadImageData(from: URL(string: userImageUrl)!) ?? Icon.cutyPotato.image
    }
    
    
}
