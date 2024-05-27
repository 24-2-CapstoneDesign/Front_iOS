//
//  EmotionUserData.swift
//  BookSpud
//
//  Created by 정의찬 on 5/26/24.
//

import Foundation

// MARK: - EmotionBookMarkData

struct EmotionUserData: Codable, Hashable {
    var information: [EmotionUserDetailData]
}

struct EmotionUserDetailData: Codable, Hashable {
    var bookMarkProfile: String
    var bookMarkName: String
}

final class EmotionUserList {
    static let data = EmotionUserDetailData(bookMarkProfile: "https://i.namu.wiki/i/KEVnfzfvHmX7Z5xiPObRD6oONcuK16ylfo5pMIZszy7grVz6yIzPvdwX_QU0kwniC0Zaap4DfuoaucYXeYscueplLOHuYAmMnlqm12hMgq-PmajGUueKozglXSGTLFMUSDdB9Z_kIwNqyHvm4KHh6Q.webp", bookMarkName: "하하하호호")
}
