//
//  EmotionUserViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/27/24.
//

import Foundation
import SwiftUI
import Combine
import Moya

class EmotionUserViewModel: ObservableObject {
    
    @Published var emotionUserData: EmotionUserData?
    @Published var emotionUserProfile: SwiftUI.Image = Icon.cutyPotato.image
    @Published var emotionUserDetailData: EmotionUserDetailData?
    
    var imageCache = ImageCacheManager.shared
    private var cancellable: AnyCancellable?
    
    // MARK: - API Property
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<BookRecommendDetailAPI>
    
    
    init(emotionUserDetailData: EmotionUserDetailData?) {
        self.emotionUserDetailData = emotionUserDetailData
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<BookRecommendDetailAPI>(session: session)
    }
    
    // MARK: - ImageFunction
    
    public func loadImage(from url: URL) {
        if let cachedImage = imageCache.loadImageData(from: url) {
            self.emotionUserProfile = cachedImage
        } else {
            downloadImage(from: url)
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
                    self.emotionUserProfile = Image(uiImage: uiImage)
                }
            })
    }
   
}
