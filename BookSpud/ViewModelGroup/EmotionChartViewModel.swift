//
//  EmotionChartViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/22/24.
//

import Foundation
import Moya

class EmotionChartViewModel: ObservableObject {
    
    // MARK: - Property
    
    @Published var emotions: [EmotionChartBeforeData]
    @Published var currentDate: String?
    @Published var userName: String = ""
    @Published var dominationEmotion: EmotionChartBeforeData
    @Published var emotionData: EmotionData? = nil
    
    var provider: MoyaProvider<EmotionChartAPITarget>
    
    
    // MARK: - Init
    
    init(
        provider: MoyaProvider<EmotionChartAPITarget> = APIManager.shared.testProvider(for: EmotionChartAPITarget.self
        )
    ) {
        let initialData = [
            EmotionChartBeforeData(name: "JOY", value: 99, color: .touchedYellow),
            EmotionChartBeforeData(name: "SADNESS", value: 29, color: .sadBlue),
            EmotionChartBeforeData(name: "ANGER", value: 59, color: .angryRed),
            EmotionChartBeforeData(name: "INSPIRATION", value: 49, color: .inspiredGreen),
            EmotionChartBeforeData(name: "MOVED", value: 69, color: .touchedPurple)
        ]
        self.emotions = initialData
        self.dominationEmotion = initialData.max(by: { $0.value < $1.value})!
        self.provider = provider
    }
    
    // MARK: - Function
    
    /// 뷰 등장 시 날짜 초기화
    private func getCurrentData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        currentDate = formatter.string(from: Date())
    }
    /// 막대 그래프
    /// - Parameter name: 막대 그래프 감정 이름
    /// - Returns: 감정 그래프 데이터 속 감정 이름
    public func stickGraphName(_ name: String) -> String {
        switch name {
        case "JOY":
            return "기쁨"
        case "SADNESS":
            return "슬픔"
        case "ANGER":
            return "화남"
        case "INSPIRATION":
            return "영감"
        case "MOVED":
            return "감동"
        default:
            return ""
        }
    }
    
    /// 감정 차트 데이터 불러오기
    public func getChartData() {
        provider.request(.getChart) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleResponse(response: response)
            case .failure(let error):
                print("차트 에러: \(error)")
            }
        }
    }
    
    /// 감정 차트 데이터 핸들 리스폰스
    /// - Parameter response: 감정 차트 핸들 리스폰스
    private func handleResponse(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(EmotionData.self, from: response.data)
            emotionData = decodedData
            updateEmotions(with: decodedData.result)
        } catch {
            print("차트 디코드 오류 : \(error)")
        }
    }
    
    /// 도넛 차트 중심 감정 표시 함수
    /// - Parameter data: 중심에 들어갈 감정 값
    private func updateEmotions(with data: EmotionDetailData) {
            let updatedData = [
                EmotionChartBeforeData(name: "JOY", value: data.JOY, color: .touchedYellow),
                EmotionChartBeforeData(name: "SADNESS", value: data.SADNESS, color: .sadBlue),
                EmotionChartBeforeData(name: "ANGER", value: data.ANGER, color: .angryRed),
                EmotionChartBeforeData(name: "INSPIRATION", value: data.INSPIRATION, color: .inspiredGreen),
                EmotionChartBeforeData(name: "MOVED", value: data.MOVED, color: .touchedPurple)
            ]
            self.emotions = updatedData
            self.dominationEmotion = updatedData.max(by: { $0.value < $1.value })!
        }
 
}
