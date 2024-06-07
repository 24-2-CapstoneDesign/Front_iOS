//
//  ISBNInputViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/30/24.
//

import Foundation
import Moya
import Combine


class ISBNInputViewModel: ObservableObject {
    
    // MARK: - Moya
    
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    private var cancellables = Set<AnyCancellable>()
    var provider: MoyaProvider<KakaoBookAPITarget>
    var bookCreate: MoyaProvider<CreateBook>
    
    @Published var scanBookData: ScanBookData? = nil {
        didSet {
            if scanBookData != nil {
                isShowSaveView = true
            } else {
                isShowSaveView = false
            }
        }
    }
    @Published var isbnText: String = "" {
        didSet {
            if !isbnText.isEmpty {
                isbnTextClicked = true
            } else {
                isbnTextClicked = false
            }
        }
    }
    @Published var isbnTextClicked: Bool = false
    @Published var showManualView: Bool = false
    @Published var scannedCode: String = ""
    @Published var isShowSaveView: Bool = false
    
    // MARK: - Init
    
    init() {
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<KakaoBookAPITarget>()
        bookCreate = MoyaProvider<CreateBook>(session: session)
        
        $scannedCode
            .dropFirst()
            .sink { [weak self] newCode in
                self?.sendISBNInfo(for: newCode)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - API Function
    
    /// 카카오로 isbn 데이터 넘기기
    /// - Parameter isbn: isbn 데이터 넘기기
    private func sendISBNInfo(for isbn: String) {
        provider.request(.sedISBN(isbnCode: isbn)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.sendISBNHandleResponse(response: response)
            case .failure(let error):
                print("책 데이터 받아오기 오류 : \(error)")
            }
        }
    }
    
    private func sendISBNHandleResponse(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(ScanBookData.self, from: response.data)
            self.scanBookData = decodedData
        }
        catch {
            print("책 정보 받아오기 오류: \(error)")
        }
    }
    
    public func sendBookInfo() {
        guard let bookData = scanBookData else { return }
        
        bookCreate.request(.createBook(bookData: bookData)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handlerResponse(response: response)
            case .failure(let error):
                print("책 저장 네트워크 오류 : \(error)")
            }
        }
    }
    
    private func handlerResponse(response: Response) {
        do {
            let decoded = try JSONDecoder().decode(BookCreateResponse.self, from: response.data)
            print("책저장 완료")
        } catch {
            print("책 저장 디코드 에러 : \(error)")
        }
    }
    
    
    // MARK: - ISBNManualView
    
    /// ISBN 수동 입력 뷰 버튼 클릭 시 작동 함수
    public func registBtn() {
        self.sendISBNInfo(for: isbnText)
    }
}
