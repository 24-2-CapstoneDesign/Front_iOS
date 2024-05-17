//
//  TopUserViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/14/24.
//

import Foundation
import Moya
import Alamofire
import SwiftUI

/// 전체 홈탭의 뷰모델 담당
class HomeViewModel: ObservableObject {
    
    // MARK: - Property
    
    /* API Propery */
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var homeuserInfoPorvider: MoyaProvider<HomeUserInfoAPITarget>
    
    
    // MARK: - API Init
    init() {
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        homeuserInfoPorvider = MoyaProvider<HomeUserInfoAPITarget>(session: session)
    }
    
}
