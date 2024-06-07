//
//  TopUserViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/17/24.
//

import Foundation
import SwiftUI
import Combine

class TopUserViewModel: ObservableObject {
    
    
    /* TopUserInfo Property */
    
    @Published var userNickname: String? = ""
    @Published var userProfileImage: URL? = nil
    
    /* Manager Property */
    public let keyChainManager = KeyChainManager.standard
    private let imageCacheManager = ImageCacheManager.shared
    private var cancellable = Set<AnyCancellable>()
    
    init(userState: UserState) {
           userState.$userName
               .assign(to: \.userNickname, on: self)
               .store(in: &cancellable)
           
           userState.$userProfile
               .assign(to: \.userProfileImage, on: self)
               .store(in: &cancellable)
       }
    
    // MARK: - UserInfoUpdate Cache
    
    public func loadUserName() {
        if let user = keyChainManager.loadSession(for: "userSession"),
           let userName = user.nickname {
            self.userNickname = userName
        }
    }
}
