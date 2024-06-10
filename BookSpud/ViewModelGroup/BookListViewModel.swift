//
//  BookListViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import Foundation
import Combine
import Moya

class BookListViewModel: ObservableObject {
    @Published var bookListBookData: BookListBookData?
    private let provider: MoyaProvider<BookListAPI>
    
    init(
        provider: MoyaProvider<BookListAPI> = APIManager.shared.createProvider(for: BookListAPI.self)
    ) {
        self.provider = provider
    }
    
    
    /// 내가 등록한 책 정보 받아오기
    public func getBookList() {
        provider.request(.bookListAPI) {[weak self] result in
            switch result {
            case .success(let response):
                self?.handleGetBook(response: response)
            case .failure(let error):
                print("네트워크 오류: \(error)")
            }
        }
    }
    
    private func handleGetBook(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(BookListBookData.self, from: response.data)
            self.bookListBookData = decodedData
            print("내가 저장 책 조회 성공")
        } catch {
            print("디코더 오류: \(error)")
        }
    }
}
