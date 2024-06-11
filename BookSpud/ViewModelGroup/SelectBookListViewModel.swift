//
//  SelectBookListViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/5/24.
//

import Foundation
import SwiftUI
import Combine
import Moya

class SelectBookListViewModel: ObservableObject {
    
    @Published var bookListBookData: BookListBookData?
    
    var provider: MoyaProvider<BookListAPI>
    
    // MARK: - Init
    
    init(provider: MoyaProvider<BookListAPI> = APIManager.shared.createProvider(for: BookListAPI.self)) {
        self.provider = provider
    }
    
    
    /// 책 전체 데이터 받아오기 API 호출 함수
    public func getBookList() {
        provider.request(.bookListAPI) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleGetBook(response: response)
            case .failure(let error):
                print("독후감 책 조회 네트워크 오류 : \(error)")
            }
        }
    }
    
    /// 책 전체 데이터 받아오기
    /// - Parameter response: 책 전체 데이터 받아오기 API Handler
    private func handleGetBook(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(BookListBookData.self, from: response.data)
            self.bookListBookData = decodedData
        } catch {
            print("독후감 책 조회 디코드 오류: \(error)")
        }
    }
}
