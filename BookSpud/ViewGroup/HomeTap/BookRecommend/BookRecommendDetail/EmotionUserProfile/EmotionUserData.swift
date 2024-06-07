//
//  EmotionUserData.swift
//  BookSpud
//
//  Created by 정의찬 on 5/26/24.
//

import Foundation

// MARK: - EmotionBookMarkData

struct EmotionUserData: Codable, Hashable {
    var status: Int
    var message: String
    var result: [EmotionUserDetailData]
}

struct EmotionUserDetailData: Codable, Hashable {
    var nickName: String
    var profileImageUrl: String
    var emotion: String
    var phase: String
    var memo: String
}
