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
import Combine


class BookMarkResgistViewModel: ObservableObject {
    
    let bookId: Int
    
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

    func recognizeText(from image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { (request, error) in
            if let observations = request.results as? [VNRecognizedTextObservation] {
                self.recognizedText = observations.compactMap { observation in
                    observation.topCandidates(1).first?.string
                }.joined(separator: " ")
            }
        }

        request.recognitionLanguages = ["ko-KR"] // 한국어 인식
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true

        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the request: \(error).")
        }
    }
    
    
    private var cancellables = Set<AnyCancellable>()
    
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<BookMarkRegistAPI>
    
    init(bookId: Int, ocrViewModel: OCRViewModel) {
        self.bookId = bookId
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<BookMarkRegistAPI>(session: session)
                
        
                ocrViewModel.$selectedText
                    .sink { [weak self] newText in
                        self?.versesText = newText
                    }
                    .store(in: &cancellables)
            }
    
    public func postBookMark() {
        let page = Int(savePage) ?? 0
        let emotion = isSelectedEmotion.emotionKey
        let data = BookMarkRegistData(phase: selectedText, page: page, memo: memoText, emotion: emotion)
        
        provider.request(.sendBookMarkRegist(id: bookId, data: data)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try  JSONDecoder().decode(ResponseBookMarkRegist.self, from: response.data)
                    print("북마크 등록 : \(decodedData.message)")
                } catch {
                    print("북마크 디코더 오류 : \(error)")
                }
            case .failure(let error):
                print("북마크 등록 네트워크 오류: \(error)")
            }
        }
    }
}
