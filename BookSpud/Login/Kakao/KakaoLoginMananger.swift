//
//  KakaoLoginMananger.swift
//  BookSpud
//
//  Created by 정의찬 on 4/12/24.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

class KakaoLoginMananger: ObservableObject {
    
    private func handleLoginResponse(oauthToken: OAuthToken?, error: Error?, completion: @escaping (Result<OAuthToken, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else if let oauthToken = oauthToken {
            completion(.success(oauthToken))
        }
    }
    
    private func kakaoLogin(completion: @escaping (Result<OAuthToken, Error>) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                self?.handleLoginResponse(oauthToken: oauthToken, error: error, completion: completion)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                self?.handleLoginResponse(oauthToken: oauthToken, error: error, completion: completion)
            }
        }
    }
    
    public func loginKakao() {
        self.kakaoLogin { result in
            switch result {
            case .success(let oauthToken):
                print("액세스 토큰 : \(oauthToken.accessToken)")
            case .failure(let error):
                print("로그인 실패 : \(error)")
            }
        }
    }
}
