//
//  LoginManager.swift
//  BookSpud
//
//  Created by 정의찬 on 4/12/24.
//

import Foundation
import SwiftUI
import Moya

class LoginViewModel: ObservableObject {
    
    private let keyChainManager = KeyChainManager.standard
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<LoginAPITarget>
    
    init() {
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<LoginAPITarget>(session: session)
    }
    
    private var kakaoLoginManager = KakaoLoginMananger()
    @Published public var isLogin: Bool = false
    
    /// 카카오톡 로그인 시도
    public func loginKakao() {
        self.kakaoLoginManager.kakaoLogin { [weak self] result in
            switch result {
            case .success(let oauthToken):
                print("액세스 토큰 : \(oauthToken.accessToken)")
                self?.sendUserInfo(token: oauthToken.accessToken)
                self?.isLogin = true

            case .failure(let error):
                print("로그인 실패 : \(error)")
            }
        }
    }
    
    
    //TODO: - 액세스 토큰 서버로 전송 코드 작성 API 호출 코드
    
    private func sendUserInfo(token: String) {
        provider.request(.loginStart(token: token)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(UserInfo.self, from: response.data)
                    let saveUserInfo = self?.keyChainManager.saveSession(decodedData, for: "userSession")
                    print("저장된 유저 정보: \(String(describing: saveUserInfo))")
                } catch {
                    print("유저 정보 저장 에러: \(error)")
                }
            case .failure(let error):
                print("네트워크 에러 : \(error)")
            }
        }
    }
}
