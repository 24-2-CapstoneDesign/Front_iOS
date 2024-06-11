//
//  ReportDraftViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/5/24.
//

import Foundation
import SwiftUI
import Combine
import Moya

class ReportDraftViewModel: ObservableObject {
    
    @Published var isLoadng: Bool = false
    
    /* 책 생성 후 받아온 책 데이터 */
    @Published var bookData: BookListDetailData
    /* 감정 입력 데이터 */
    @Published var inputEmotionData: InputEmotionData?
    /* 독후감 세부 상세 조회 데이터*/
    @Published var detailBookReport: ShowDetailBook?
    /* 초안 생성 후 받은 서론 본론 결론 데이터 */
    @Published var responseMakeDraft: ResponseMakeDraft?
    /* 논점 전달 후 받은 id 값 */
    @Published var responseArguments: ResponseArguments?
    /* 서론 본론 결론 질문 데이터*/
    @Published var answerData: ResponseAnswer?
    /* 논점 받아오기 데이터 */
    @Published var draftData: DraftReportData?
    /* 논점 선택 -> 서론 -> 본론 -> 결론 질문 생성 페이지 카운트 */
    @Published var currentPageIndex: Int = 0
    
    // MARK: - ArgumentView
    
    /// 선택한 논점 저장
    @Published var selectedArgument: String? = nil {
        didSet {
            if selectedArgument != nil {
                checkZeroBtn = true
            }
        }
    }
    /// 다음 활성화 버튼
    @Published var checkZeroBtn: Bool = false
    
    // MARK: - Answer
    
    /* FirstView(서론) */
    @Published var firstAnswer: String = "" {
        didSet {
            if !firstAnswer.isEmpty {
                checkFirstBtn = true
            }
        }
    }
    /// 다음 활성화 버튼
    @Published var checkFirstBtn: Bool = false
    
    /* SecondView(본론) */
    @Published var secondAnswer: String = "" {
        didSet {
            if !secondAnswer.isEmpty {
                checkSecondBtn = true
            }
        }
    }
    @Published var checkSecondBtn: Bool = false
    
    /* thirdView(결론) */
    @Published var thirdAnswer: String = "" {
        didSet {
            if !thirdAnswer.isEmpty {
                checkThirdBtn = true
            }
        }
    }
    
    @Published var checkThirdBtn: Bool = false
    
    // MARK: - API Property
    var provider: MoyaProvider<ReportAPITarget>
    
    
    init(
        bookData: BookListDetailData,
        provider: MoyaProvider<ReportAPITarget> = APIManager.shared.createProvider(for: ReportAPITarget.self)
    ) {
        self.bookData = bookData
        self.provider = provider
    }
    
    // MARK: - ArgumentAPI
    
    /// 논점 받아오기 API 함수
    /// - Parameter bookId: 해당 책의 id
    public func getArguments(bookId: Int) {
        isLoadng = true
        provider.request(.selectArgument(myBookId: bookId)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleGetArgument(response: response)
            case .failure(let error):
                print("논점 네트워크 에러: \(error)")
                self?.isLoadng = false
            }
        }
    }
    
    /// 논점 받아오는 핸들러 함수
    /// - Parameter response: 논점 받아오기 API response
    private func handleGetArgument(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(DraftReportData.self, from: response.data)
            self.draftData = decodedData
        } catch {
            print("논점 디코드 오류 : \(error)")
        }
        isLoadng = false
    }
    
    /// 논점 전달 API 함수
    /// - Parameters:
    ///   - bookId: 논점 전달할 책 Id
    ///   - argument: 선택한 논점 전달
    public func postArguments(bookId: Int, argument: String) {
        provider.request(.postDraft(myBookId: bookId, argument: argument)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handlePostArgument(response: response)
            case .failure(let error):
                print("논점 네트워크 에러: \(error)")
            }
        }
    }
    
    /// 논점 전달 API 핸들러
    /// - Parameter response: 논점 전달 후, response Data
    private func handlePostArgument(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(ResponseArguments.self, from: response.data)
            self.responseArguments = decodedData
        } catch {
            print("논점 전달 디코드 에러 : \(error)")
        }
    }
    
    // MARK: - QuestionAPI
    
    /// 질문 받아오는 API
    /// - Parameter argumentId: 논점 선택 후 받아온 id값
    public func getAnswer(argumentId: Int) {
        isLoadng = true
        provider.request(.getQuestion(argumentId: argumentId)) {[weak self] result in
            switch result {
            case .success(let response):
                self?.handleGetAnswer(response: response)
            case .failure(let error):
                print("질문 네트워크 에러: \(error)")
                self?.isLoadng = false
            }
        }
    }
    
    /// 서론 본론 결론 질문 받아오는 API 핸들러
    /// - Parameter response: 전달 받은 데이터 값
    private func handleGetAnswer(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(ResponseAnswer.self, from: response.data)
            self.answerData = decodedData
        } catch {
            print("질문 디코드 오류: \(error)")
        }
        isLoadng = false
    }
    
    
    /// 질문 작성 후 초안 생성 API 함수
    /// - Parameter argumentId: 논점 생성 후 받아온 Id 값
    public func makeDraft(argumentId: Int) {
        provider.request(.makeDraft(argumentId: argumentId, data: createDraft())) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleMakeDraft(response: response)
            case.failure(let error):
                print("초안 생성 네트워크 에러: \(error)")
            }
        }
    }
    
    /// 초안 생성 API 호출 핸들러
    /// - Parameter response: 호출 후 받아온 response
    private func handleMakeDraft(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(ResponseMakeDraft.self, from: response.data)
            self.responseMakeDraft = decodedData
        } catch {
            print("초안 생성 결과 디코드 에러: \(error)")
        }
    }
    
    /// 초안 생성 시 필요한 데이터 구조
    /// - Returns: MakeDraft 타입 반환
    private func createDraft() -> MakeDraft {
        
        if let data = answerData {
            return MakeDraft(
                introQuestion: data.result.introQuestion,
                introAnswer: firstAnswer,
                bodyQuestion: data.result.bodyQuestion,
                bodyAnswer: secondAnswer,
                conclusionQuestion: data.result.conclusionQuestion,
                conclusionAnswer: thirdAnswer)
        } else {
            return MakeDraft(
                introQuestion: "",
                introAnswer: "",
                bodyQuestion: "",
                bodyAnswer: "",
                conclusionQuestion: "",
                conclusionAnswer: "")
        }
    }
    
    // MARK: - ReadReport
    
    /// 독후감 세부 상세 조회 API
    /// - Parameter argumentId: 논점 생성 후 받은 id 값
    public func showDetailBookReport(argumentId: Int) {
        provider.request(.detailBookreport(argumentId: argumentId)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleShowDetailReport(response: response)
            case .failure(let error):
                print("상세 독후감 네트워크 오류: \(error)")
            }
        }
    }
    
    /// 독후감 세부 상세 조회 API 핸들러
    /// - Parameter response: 상세 조회 후 받은 response
    private func handleShowDetailReport(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(ShowDetailBook.self, from: response.data)
            self.detailBookReport = decodedData
        } catch {
            print("상세 독후감 디코드 에러: \(error)")
        }
    }
    
    /// 최종본 등록 API
    /// - Parameters:
    ///   - argumentId: 논점 Id
    ///   - inputData: 입력한 감정 데이터
    public func makeFinalReport(argumentId: Int, inputData: InputEmotionData) {
        provider.request(.makeFinalReport(argumentId: argumentId, inputData: inputData)) { [weak self] result in
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
}
