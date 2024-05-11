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
    @StateObject private var profileViewModel = ProfileViewModel()
    
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "5446287ceb12e71a169594ebed02e85a")
    }
    
    var body: some Scene {
        WindowGroup {
            if !loginViewModel.isLogin {
                LoginView(loginViewModel: loginViewModel)
            } else if !profileViewModel.isProfileCompleted {
                ProfileSettingView(profileVM: profileViewModel)
            } else {
                BookSpudTabView()
            }
        }
    }
}
