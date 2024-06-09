//
//  AppState.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation

/// 닉네임 설정과 홈 로드 간의 상태 관리
class UserState: ObservableObject {
    @Published var userName: String? = nil
    @Published var userProfile: URL? = nil
    
    private let keyChain = KeyChainManager.standard
    
    /// 유저 닉네임 업데이트
    public func loadUserName() {
        if let user = keyChain.loadSession(for: "userSession"),
           let userName = user.nickname {
            self.userName = userName
            print("저장된 유저 정보 : \(userName)")
        }
    }
    
    /// 유저 닉네임 업데이트
    /// - Parameter userName: 유저 닉네임 업데이트
    public func updateName(userName: String) {
        self.userName = userName
    }
    
    /// 유저 프로필 업데이트
    public func loadUserProfile() {
        if let user = keyChain.loadSession(for: "userSession"),
           let profileImageURL = user.profileImageURL,
           let url = URL(string: profileImageURL) {
            self.userProfile = url
        }
    }
    
    public func updateURL(userURL: URL) {
        self.userProfile = userURL
    }
}
