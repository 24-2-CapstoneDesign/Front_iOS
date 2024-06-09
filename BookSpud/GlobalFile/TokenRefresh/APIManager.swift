//
//  APIManager.swift
//  BookSpud
//
//  Created by 정의찬 on 6/9/24.
//

import Foundation
import Moya

/// 중복되는 토큰 자동 갱신 및 헤더 액세스 토큰 첨부 코드 클래스 캡슐화
class APIManager {
    static let shared = APIManager()
    
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    
    private init() {
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
    }
    
    public func createProvider<T: TargetType>(for targetType: T.Type) -> MoyaProvider<T> {
        return MoyaProvider<T>(session: session)
    }
}
