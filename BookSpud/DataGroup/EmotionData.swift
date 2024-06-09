//
//  EmotionData.swift
//  BookSpud
//
//  Created by 정의찬 on 5/17/24.
//

import Foundation
import SwiftUI

/// EmotionPicker뷰 구성 데이터
struct EmotionPickerData: Identifiable {
    var id: String { name }
    var name: String
    var emotionImage: Image
}

final class EmotionDataList {
    static let emotionList: [EmotionPickerData] = [
        EmotionPickerData(name: "JOY", emotionImage: Icon.happyEmotion.image),
        EmotionPickerData(name: "SADNESS", emotionImage: Icon.sadEmotion.image),
        EmotionPickerData(name: "ANGER", emotionImage: Icon.angryEmotion.image),
        EmotionPickerData(name: "INSPIRATION", emotionImage: Icon.inspirationEmotion.image),
        EmotionPickerData(name: "MOVED", emotionImage: Icon.moveEmotion.image)
    ]
}


// MARK: - BookVerses API Data

/// 북 감정 구절 받아오기 구절
struct BookVerses: Codable {
    var status: Int
    var message: String
    var result: DetailBookVerses
}

struct DetailBookVerses: Codable {
    var emotion: String
    var phase: String
    var title: String
    var cover: String
    
    init(emotion: String, phase: String, title: String, cover: String) {
        self.emotion = emotion
        self.phase = phase
        self.title = title
        self.cover = cover
    }
}


