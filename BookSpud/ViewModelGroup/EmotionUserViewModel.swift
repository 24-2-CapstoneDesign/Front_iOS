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
   
}
