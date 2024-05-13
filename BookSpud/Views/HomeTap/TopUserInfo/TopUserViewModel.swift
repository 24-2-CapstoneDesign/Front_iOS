//
//  TopUserViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/14/24.
//

import Foundation
import Moya
import Alamofire

class TopUserViewModel: ObservableObject {
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<HomeUserInfoAPITarget>
    
    init() {
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<HomeUserInfoAPITarget>(session: session)
    }
}
