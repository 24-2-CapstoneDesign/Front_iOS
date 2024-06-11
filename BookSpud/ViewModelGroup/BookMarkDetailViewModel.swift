//
//  BookMardDetailViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/11/24.
//

import Foundation
import SwiftUI
import Moya

class BookMarkDetailViewModel: ObservableObject {
    
    @Published var bookMarkData: IndividualBookMark?
    @Published var isLoading: Bool = false
    
    /* 북마크 생성 시, 사용되는 감정 표현 이모티콘과 구문 */
    @Published var emotionImg: SwiftUI.Image = Icon.happySpud.image
    @Published var emotionTextImg: SwiftUI.Image = Icon.happyEmotion.image
    @Published var userName: String = ""
    
    let provider: MoyaProvider<BookMarkReadAPITarget>
    
    init(
        bookMarkData: IndividualBookMark? = nil,
        provider: MoyaProvider<BookMarkReadAPITarget> = APIManager.shared.createProvider(for: BookMarkReadAPITarget.self))
    {
        self.bookMarkData = bookMarkData
        self.provider = provider
    }
    
    
    public func loadSession() {
        if let user = KeyChainManager.standard.loadSession(for: "userSession"),
           let name = user.nickname {
            self.userName = name
        }
    }
    
    
    // MARK: - BookMarkCreatFunction
    
    /// 북마크 생성 시 선택하는 감정 함수
    /// - Parameter emotion: 선택한 감정 값
    private func emotionImageChange(_ emotion: String){
        switch emotion {
        case "JOY":
            self.emotionTextImg = Icon.happyEmotion.image
            self.emotionImg = Icon.happySpud.image
        case "SADNESS":
            self.emotionTextImg = Icon.sadEmotion.image
            self.emotionImg = Icon.sadSpud.image
        case "ANGER":
            self.emotionTextImg = Icon.angryEmotion.image
            self.emotionImg = Icon.angrySpud.image
        case "INSPIRATION":
            self.emotionTextImg = Icon.inspirationEmotion.image
            self.emotionImg = Icon.inspirationSpud.image
        case "MOVED":
            self.emotionTextImg = Icon.moveEmotion.image
            self.emotionImg = Icon.sensationSpud.image
        default:
            break
        }
    }
    
    // MARK: - API
    
    public func getBookMarkInfo(id: Int) {
        self.isLoading = true
        print("조회 id:\(id)")
        provider.request(.bookMarkRead(id: id)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handlerBookMarkResponse(response: response)
            case .failure(let error):
                print("북마크 정보 네트워크 오류: \(error)")
            }
        }
    }
    
    private func handlerBookMarkResponse(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(IndividualBookMark.self, from: response.data)
            self.bookMarkData = decodedData
            self.emotionImageChange(bookMarkData?.result.emotion ?? "JOY")
            self.isLoading = false  
        } catch {
            print("북마크 정보 데이터 디코드 오류 : \(error)")
        }
    }
}
