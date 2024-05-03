//
//  BookSpudApp.swift
//  BookSpud
//
//  Created by 정의찬 on 4/12/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct BookSpudApp: App {
    
    @StateObject private var loginViewModel = LoginViewModel()
    
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "5446287ceb12e71a169594ebed02e85a")
    }
    
    var body: some Scene {
        WindowGroup {
            if loginViewModel.isLogin == false{
                LoginView(loginViewModel: loginViewModel)
            } else {
                ProfileSettingView()
            }
        }
    }
}
