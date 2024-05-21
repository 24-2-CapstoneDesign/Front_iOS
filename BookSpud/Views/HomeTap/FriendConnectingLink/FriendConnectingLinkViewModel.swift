//
//  FriendConnectingLinkViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import Foundation

/// 추천책 뷰 전체 뷰모델
class FriendConnectingLinkViewModel: ObservableObject {
    @Published var friendConnecting: FriendConnectingData?
    
    init(friendConnecting: FriendConnectingData? = nil) {
        self.friendConnecting = friendConnecting
    }
}
