//
//  EmotionData.swift
//  BookSpud
//
//  Created by 정의찬 on 5/17/24.
//

import Foundation
import SwiftUI

struct EmotionData: Identifiable {
    var id: String { name }
    var name: String
    var emotionImage: Image
}

struct BookVerses: Codable {
    var verses: String
    var bookImgURL: String
}

final class EmotionDataList {
    static let emotionList: [EmotionData] = [
        EmotionData(name: "happy", emotionImage: Icon.happyEmtion.image),
        EmotionData(name: "sad", emotionImage: Icon.sadEmotion.image),
        EmotionData(name: "angry", emotionImage: Icon.angryEmotion.image),
        EmotionData(name: "inspiration", emotionImage: Icon.inspirationEmotion.image),
        EmotionData(name: "move", emotionImage: Icon.moveEmotion.image)
    ]
}
