//
//  BookDetailViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import Foundation
import SwiftUI
import Moya

class BookDetailViewModel: ObservableObject {
    @Published var bookListDetailData: BookListDetailData
    
    /* 해당 책이 들고 있는 북마크 데이터 */
    @Published var bookMarkData: BookMarkData?
    
    @Published var verses: String = ""
    @Published var memo: String = ""
    @Published var page: Int = 0
    @Published var emotion: String = ""
    
    var provider: MoyaProvider<BookListDetailAPI>
    
    
    // MARK: - LoadUser
    
    public func loadSession() -> String {
        if let user = KeyChainManager.standard.loadSession(for: "userSession"),
           let name = user.nickname {
            return name
        } else {
            return "유저 정보 없음"
        }
    }
    
    // MARK: - Init
    
    init(bookListDetailData: BookListDetailData,
         provider: MoyaProvider<BookListDetailAPI> = APIManager.shared.createProvider(for: BookListDetailAPI.self)
    ) {
        self.bookListDetailData = bookListDetailData
        self.provider = provider
    }
    
    // MARK: - GetBookMarkData API
    
    /// 해당 책이 들고 있는 북마크를 불러온다. 해당책은 내가 저장한 책
    /// - Parameter id: 내가 저장해서 받아온 책 id 값을 파라미터로 사용한다.
    public func getBookMark(id: Int) {
        provider.request(.getBookMark(id: id)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleGetBookMarkResponse(response: response)
            case .failure(let error):
                print("북마크 조회 에러: \(error)")
            }
        }
    }

    
    /// 해당 책이 들고 있는 북마크 조회 핸들러
    /// - Parameter response: API response 값 전달
    private func handleGetBookMarkResponse(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(BookMarkData.self, from: response.data)
            self.bookMarkData = decodedData
        } catch {
            print("북마크 디코더 에러: \(error)")
        }
    }
    
    // MARK: - PatchPage API
    
    /// 현재까지 읽은 페이지 업데이트
    /// - Parameters:
    ///   - id: 책이 들고 있는 고유 id
    ///   - bookData: 등록한 책 데이터를 저장한 데이터 변수
    public func patchPage(id: Int, bookData: BookListDetailData) {
        provider.request(.pageUpdagte(id: id, bookData: bookData)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handlePatchPage(response: response)
            case .failure(let error):
                print("페이지 업데이트 네트워크 에러: \(error)")
            }
        }
    }
    
    /// 현재까지 읽은 페이지 업데이트 핸들러
    /// - Parameter response: 페이지 업데이트  API Response
    private func handlePatchPage(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(BookPageData.self, from: response.data)
            print("페이지 업데이트 완료: \(decodedData.status)")
        } catch {
            print("페이지 업데이트 디코드 \(error)")
        }
    }
}
