//
//  BookMarkResgistViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import Foundation
import SwiftUI
import Vision
import VisionKit
import Moya


class BookMarkRegistViewModel: ObservableObject {
    
    @Published var versesText: String = ""
    @Published var memoText: String = ""
    @Published var isShowOCR: Bool = false
    @Published var isCamera: Bool = false
    @Published var savePage: String = ""
    @Published var isSelectedEmotion: BookEmotionKind = .happy
    
    @Published var recognizedText = "" {
        didSet {
            sentences = recognizedText.split(separator: ".").map { String($0).trimmingCharacters(in: .whitespaces) + "." }
        }
    }
    @Published var sentences: [String] = []
    @Published var selectedText: String = ""

    let bookId: Int
    var provider: MoyaProvider<BookMarkRegistAPI>
    
    // MARK: - Init
    
    init(bookId: Int,
         provider: MoyaProvider<BookMarkRegistAPI> = APIManager.shared.createProvider(for: BookMarkRegistAPI.self)
    ) {
        self.bookId = bookId
        self.provider = provider
    }
    
    
    // MARK: - Post BoookMarkData
    
    /// 북마크 데이터 API 전달
    public func postBookMark() {
        let page = Int(savePage) ?? 0
        let emotion = isSelectedEmotion.emotionKey
        let data = BookMarkRegistData(phase: selectedText, page: page, memo: memoText, emotion: emotion)
        
        provider.request(.sendBookMarkRegist(id: bookId, data: data)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleBookMarkData(response: response)
            case .failure(let error):
                print("북마크 등록 네트워크 오류: \(error)")
            }
        }
    }
    
    private func handleBookMarkData(response: Response) {
        do {
            do {
                let decodedData = try  JSONDecoder().decode(ResponseBookMarkRegist.self, from: response.data)
                print("북마크 등록 : \(decodedData.message)")
            } catch {
                print("북마크 디코더 오류 : \(error)")
            }
        }
    }
    
    
}
