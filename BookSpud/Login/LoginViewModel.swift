//
//  LoginManager.swift
//  BookSpud
//
//  Created by 정의찬 on 4/12/24.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    private var kakaoLoginManager = KakaoLoginMananger()
    @Published public var isLogin: Bool = false
    
    public func loginKakao() {
        self.kakaoLoginManager.kakaoLogin { [weak self] result in
            switch result {
            case .success(let oauthToken):
                print("액세스 토큰 : \(oauthToken.accessToken)")
                self?.isLogin = true

            case .failure(let error):
                print("로그인 실패 : \(error)")
            }
        }
    }
}
