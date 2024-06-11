//
//  CheckingUserBookMarkViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/27/24.
//

import Foundation
import SwiftUI

class CheckingUserBookMarkViewModel: ObservableObject {
    @Published var checkingUserBookData: EmotionUserDetailData
    @Published var emotionImg: SwiftUI.Image = Icon.happySpud.image
    @Published var emotionTextImg: SwiftUI.Image = Icon.happyEmotion.image
    
    init(checkingUserBookData: EmotionUserDetailData) {
        self.checkingUserBookData = checkingUserBookData
    }
    
    /// 감정 이미지 변환
    /// - Parameter emotion: 저장된 감정 데이터
    public func emotionImageChange(_ emotion: String) {
        switch emotion {
        case "JOY":
            self.emotionTextImg = Icon.happyEmotion.image
            self.emotionImg = Icon.happySpud.image
        case "SADNESS":
            self.emotionTextImg = Icon.sadEmotion.image
            self.emotionImg = Icon.sadSpud.image
        case "ANGER":
            self.emotionTextImg = Icon.angryEmotion.image
            self.emotionImg = Icon.angrySpud.image
        case "INSPIRATION":
            self.emotionTextImg = Icon.inspirationEmotion.image
            self.emotionImg = Icon.inspirationSpud.image
        case "MOVED":
            self.emotionTextImg = Icon.moveEmotion.image
            self.emotionImg = Icon.sensationSpud.image
        default:
            break
        }
    }
}
