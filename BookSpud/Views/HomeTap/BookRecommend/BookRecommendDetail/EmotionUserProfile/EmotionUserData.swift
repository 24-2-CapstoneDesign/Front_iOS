//
//  EmotionUserData.swift
//  BookSpud
//
//  Created by 정의찬 on 5/26/24.
//

import Foundation

// MARK: - EmotionBookMarkData

struct EmotionUserData: Codable {
    var information: [EmotionUserDetailData]
}

struct EmotionUserDetailData: Codable, Hashable {
    var bookMarkProfile: String
    var bookMarkName: String
}
