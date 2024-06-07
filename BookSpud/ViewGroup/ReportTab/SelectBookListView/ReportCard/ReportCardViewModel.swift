//
//  ReportCardViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/5/24.
//

import Foundation
import SwiftUI
import Combine
import Moya

class ReportCardViewModel: ObservableObject {
    @Published var bookReportResponse: BookReportResponse
    @Published var bookCover: SwiftUI.Image?
    
    @Published var introEmotion: String = ""
    @Published var bodyEmotion: String = ""
    @Published var conclusionEmotion: String = ""
    
    
    // MARK: - API Property
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<ReportCardAPITarget>
    
    
    
    init(bookReportResponse: BookReportResponse) {
        self.bookReportResponse = bookReportResponse
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<ReportCardAPITarget>(session: session)
    }
    
    
    let imageCache = ImageCacheManager.shared
    private var cancellable: AnyCancellable?
    
    
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
    
    public func patchEmotion(id: Int) {
        provider.request(.sendEmotionData(id: id, first: introEmotion, second: bodyEmotion, third: conclusionEmotion)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ResponseEmotionPatch.self, from: response.data)
                    print(decodedData.message)
                } catch {
                    print("감정 값 디코드 에러: \(error)")
                }
            case .failure(let error):
                print("감정 값 네트워크 에러: \(error)")
            }
        }
        
    }
}
