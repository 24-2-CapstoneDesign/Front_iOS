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
    
    @Published var detailBookReport: ShowDetailBook?
    @Published var responseMakeDraft: ResponseMakeDraft?
    @Published var responseArguments: ResponseArguments?
    @Published var answerData: ResponseAnswer?
    @Published var draftData: DraftReportData?
    @Published var data: BookListDetailData?
    @Published var currentPageIndex: Int = 0
    @Published var bookCover: SwiftUI.Image?
    
    // MARK: - ArgumentView
    
    @Published var selectedArgument: String? = nil {
        didSet {
            if selectedArgument != nil {
                checkZeroBtn = true
            }
        }
    }
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
    
    let imageCache = ImageCacheManager.shared
    private var cancellable: AnyCancellable?
    
    // MARK: - API Property
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<ReportAPITarget>
    
    
    init(data: BookListDetailData? = nil) {
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<ReportAPITarget>(session: session)
        self.data = data
    }
    
    // MARK: - ImageFunction
    
    public func loadImage(from url: URL) {
        if let cachedImage = imageCache.loadImageData(from: url) {
            self.bookCover = cachedImage
        } 
    }
    
    private func downloadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .catch { _ in Just(Data()) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in}, receiveValue: {
                [weak self] data in
                guard !data.isEmpty, let self = self else { return }
                imageCache.downloadAndSaveImage(from: url)
                if let uiImage = UIImage(data: data) {
                    self.bookCover = Image(uiImage: uiImage)
                }
            })
    }
    
    public func getArguments(id: Int) {
        provider.request(.getDraft(id: id)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(DraftReportData.self, from: response.data)
                    self?.draftData = decodedData
                } catch {
                    print("논점 디코드 오류 : \(error)")
                }
            case .failure(let error):
                print("논점 네트워크 에러: \(error)")
            }
            
        }
    }
    
    public func postArguments(id: Int, argument: String) {
        provider.request(.postDraft(id: id, argument: argument)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ResponseArguments.self, from: response.data)
                    self?.responseArguments = decodedData
                    print(self?.responseArguments?.result)
                } catch {
                    print("논점 전달 디코드 에러 : \(error)")
                }
            case .failure(let error):
                print("논점 네트워크 에러: \(error)")
            }
        }
    }
    
    public func getAnswer(id: Int) {
        provider.request(.getQuestion(id: id)) {[weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ResponseAnswer.self, from: response.data)
                    self?.answerData = decodedData
                } catch {
                    print("질문 디코드 오류: \(error)")
                }
            case .failure(let error):
                print("질문 네트워크 에러: \(error)")
            }
        }
    }
    
    public func makeDraft(id: Int) {
        provider.request(.makeDraft(id: id, data: createDraft())) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ResponseMakeDraft.self, from: response.data)
                    self?.responseMakeDraft = decodedData
                } catch {
                    print("초안 생성 결과 디코드 에러: \(error)")
                }
            case.failure(let error):
                print("초안 생성 네트워크 에러: \(error)")
            }
        }
    }
    
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
    
    public func showDetailBookReport(id: Int) {
        print("아이디값 : \(id)")
        provider.request(.detailBookreport(id: id)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ShowDetailBook.self, from: response
                        .data)
                    self?.detailBookReport = decodedData
                    print(self?.detailBookReport)
                } catch {
                    print("상제 독후감 디코드 에러: \(error)")
                }
            case .failure(let error):
                print("상세 독후감 네트워크 오류: \(error)")
            }
        }
    }
}
