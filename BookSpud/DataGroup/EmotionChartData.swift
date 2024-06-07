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
    var status: Int
    var message: String
    var result: EmotionDetailData
}

struct EmotionDetailData: Codable {
    var JOY: Int
    var SADNESS: Int
    var ANGER:  Int
    var INSPIRATION: Int
    var MOVED: Int
}
