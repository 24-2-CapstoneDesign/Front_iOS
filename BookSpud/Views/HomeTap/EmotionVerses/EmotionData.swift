//
//  EmotionData.swift
//  BookSpud
//
//  Created by 정의찬 on 5/17/24.
//

import Foundation
import SwiftUI

struct EmotionPickerData: Identifiable {
    var id: String { name }
    var name: String
    var emotionImage: Image
}

struct BookVerses: Codable {
    var verses: String?
    var bookName: String?
    var bookImgURL: String?
}

final class EmotionDataList {
    static let emotionList: [EmotionPickerData] = [
        EmotionPickerData(name: "happy", emotionImage: Icon.happyEmtion.image),
        EmotionPickerData(name: "sad", emotionImage: Icon.sadEmotion.image),
        EmotionPickerData(name: "angry", emotionImage: Icon.angryEmotion.image),
        EmotionPickerData(name: "inspiration", emotionImage: Icon.inspirationEmotion.image),
        EmotionPickerData(name: "move", emotionImage: Icon.moveEmotion.image)
    ]
}
