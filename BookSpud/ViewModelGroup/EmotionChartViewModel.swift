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
    
    let keyChainManager = KeyChainManager.standard
    // MARK: - API Property
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<EmotionAPITarget>
    
    
    // MARK: - Init
    
    init() {
        let initialData = [
            EmotionChartBeforeData(name: "JOY", value: 99, color: .touchedYellow),
            EmotionChartBeforeData(name: "SADNESS", value: 29, color: .sadBlue),
            EmotionChartBeforeData(name: "ANGER", value: 59, color: .angryRed),
            EmotionChartBeforeData(name: "INSPIRATION", value: 49, color: .inspiredGreen),
            EmotionChartBeforeData(name: "MOVED", value: 69, color: .touchedPurple)
        ]
        self.emotions = initialData
        self.dominationEmotion = initialData.max(by: { $0.value < $1.value})!
        
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<EmotionAPITarget>(session: session)
    }
    
    public func loadUser() {
        if let user = KeyChainManager.standard.loadSession(for: "userSession"),
           let name = user.nickname {
            self.userName = name
        }
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
    
    //TODO: - EmotionData API로 받아온 후, 값 할당 하는 함수 필요
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
    
    private func handleResponse(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(EmotionData.self, from: response.data)
            emotionData = decodedData
            updateEmotions(with: decodedData.result)
        } catch {
            print("차트 디코드 오류 : \(error)")
        }
    }
    
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
