//
//  EmotionData.swift
//  BookSpud
//
//  Created by 정의찬 on 5/22/24.
//

import Foundation
import SwiftUI

struct EmotionChartBeforeData: Identifiable {
    var id = UUID()
    let name: String
    let value: Int
    let color: Color
}

struct EmotionData: Codable {
    var information: [EmotionDetailData]
}

struct EmotionDetailData: Codable {
    var name: String
    var value: Int
}