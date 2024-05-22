//
//  EmotionChartViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/22/24.
//

import Foundation

class EmotionChartViewModel: ObservableObject {
    
    @Published var emotions: [EmotionChartData]
    @Published var currentDate: String?
    @Published var userName: String = ""
    @Published var dominationEmotion: EmotionChartData
    let keyChainManager = KeyChainManager.standard
    
    init() {
        let initialData = [
            EmotionChartData(name: "happyEmtion", value: 99, color: .touchedYellow),
            EmotionChartData(name: "sadEmotion", value: 29, color: .sadBlue),
            EmotionChartData(name: "angryEmotion", value: 59, color: .angryRed),
            EmotionChartData(name: "inspirationEmotion", value: 49, color: .inspiredGreen),
            EmotionChartData(name: "moveEmotion", value: 69, color: .touchedPurple)
        ]
        self.emotions = initialData
        self.dominationEmotion = initialData.max(by: { $0.value < $1.value})!
    }
    
    // MARK: - Function
    
    /// 뷰 등장 시 날짜 초기화
    private func getCurrentData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        currentDate = formatter.string(from: Date())
    }
    
    /// 키체인에 등록된 유저 닉네임 가져오기
    private func getUserName() {
        guard let userInfo = keyChainManager.loadSession(for: "userSession") else { return }
        
        userName = userInfo.nickname ?? "감자"
    }
    
    /// 차트 뷰 등장 시 값 초기화
    public func onApearData() {
        getCurrentData()
        getUserName()
    }
    
    /// 막대 그래프
    /// - Parameter name: 막대 그래프 감정 이름
    /// - Returns: 감정 그래프 데이터 속 감정 이름
    public func stickGraphName(_ name: String) -> String {
        switch name {
        case "happyEmtion":
            return "기쁨"
        case "sadEmotion":
            return "슬픔"
        case "angryEmotion":
            return "화남"
        case "inspirationEmotion":
            return "영감"
        case "moveEmotion":
            return "감동"
        default:
            return ""
        }
    }
    
 
}
