//
//  DetailReportViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/11/24.
//

import Foundation
import Moya

class DetailReportViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    

    @Published var introEmotionText: String = ""
    @Published var bodyEmotionText: String = ""
    @Published var conclustionEmotionText: String = ""
    
    
    @Published var introPlace: String = ""
    @Published var bodyPlace: String = ""
    @Published var conclustionPlace: String = ""
    
    @Published var bookData: BookReportResponse
    /* 감정 가이드 질문 */
    @Published var emotionGuide: [EmotionGuideQuestion]?
    /* 감정 입력 데이터 */
    @Published var inputEmotionData: InputEmotionData?
    /* 독후감 세부 상세 조회 데이터*/
    @Published var detailBookReport: ShowDetailBook?
    
    let provider: MoyaProvider<ReportAPITarget>
    
    init(bookData: BookReportResponse,
        provider: MoyaProvider<ReportAPITarget> = APIManager.shared.createProvider(for: ReportAPITarget.self)
    ) {
        self.bookData = bookData
        self.provider = provider
    }
    
    
    // MARK: - DetailReport API
    
    /// 독후감 세부 상세 조회 API
    /// - Parameter argumentId: 논점 생성 후 받은 id 값
    public func showDetailBookReport(argumentId: Int) {
        isLoading = true
        provider.request(.detailBookreport(argumentId: argumentId)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleShowDetailReport(response: response)
            case .failure(let error):
                print("상세 독후감 네트워크 오류: \(error)")
                self?.isLoading = false
            }
        }
    }
    
    /// 독후감 세부 상세 조회 API 핸들러
    /// - Parameter response: 상세 조회 후 받은 response
    private func handleShowDetailReport(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(ShowDetailBook.self, from: response.data)
            self.detailBookReport = decodedData
            self.valueMatching()
        } catch {
            print("상세 독후감 디코드 에러: \(error)")
        }
        isLoading = false
    }
    
    // MARK: - RegistFinal Regist
    /// 최종본 등록 API
    /// - Parameters:
    ///   - argumentId: 논점 Id
    ///   - inputData: 입력한 감정 데이터
    public func makeFinalReport(argumentId: Int) {
        provider.request(.makeFinalReport(argumentId: argumentId, inputData: createInputEmotionData())) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleMakeFinalReport(response: response)
            case .failure(let error):
                print("최종본 네트워크 오류: \(error)")
            }
        }
    }
    
    /// 최종본 등록 API 핸들러
    /// - Parameter response: 최종본 등록 response
    private func handleMakeFinalReport(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(ResponseEmotionData.self, from: response.data)
            print("최종본 생성 성공: \(decodedData)")
        } catch {
            print("최종본 디코드 에러: \(error)")
        }
    }
    
    // MARK: - EmotionGuid API
    /// 감정 추천 질문 조회
    public func emotionGuideQuestion() {
        provider.request(.emotionGuide) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleEmotionGuide(response: response)
            case .failure(let error):
                print("네트워크 에러: \(error)")
            }
        }
    }
    
    /// 감정 추천 질문 작성 핸들러
    /// - Parameter response: 전달 받은 데이터
    private func handleEmotionGuide(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(EmotionGuide.self, from: response.data)
            self.emotionGuide = decodedData.result.questionGuides
        } catch {
            print("감정 질문 디코드 에러: \(error)")
        }
    }
    
    /// 질문 랜덤 생성
    /// - Returns: 랜덤 생성된 질문
    public func getQuestionRandom() -> String {
        guard let questions = emotionGuide, !questions.isEmpty else { return "" }
        return questions.randomElement()?.question ?? ""
    }
    
    /// 입력한 감정 데이터 타입 전달
    /// - Returns: API 전달 타입
    private func createInputEmotionData() -> InputEmotionData {
        return InputEmotionData(introEmotion: self.introEmotionText,
                                bodyEmotion: self.bodyEmotionText,
                                conclusionEmotion: self.conclustionEmotionText)
    }
    
    private func valueMatching() {
        if let data = detailBookReport?.result,
           let intro = data.introEmotion,
           let body = data.bodyEmotion,
           let conclu = data.conclusionEmotion {
            self.introEmotionText = intro
            self.bodyEmotionText = body
            self.conclustionEmotionText = conclu
        }
    }
}
