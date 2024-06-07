//
//  BookSpudApp.swift
//  BookSpud
//
//  Created by 정의찬 on 4/12/24.


import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import AVFoundation

@main
struct BookSpudApp: App {
    
    @StateObject private var userState = UserState()
    @StateObject private var loginViewModel = LoginViewModel()
    @StateObject private var profileViewModel = ProfileViewModel()
    @State private var showOnboard: Bool = true
    
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "5446287ceb12e71a169594ebed02e85a")
    }
    
    var body: some Scene {
        WindowGroup {
            if showOnboard {
                OnBoardScreen(showOnboard: $showOnboard)
            } else if !loginViewModel.isLogin {
                LoginView(loginViewModel: loginViewModel)
            } else if !profileViewModel.isProfileCompleted {
                ProfileSettingView(viewModel: profileViewModel)
                    .environmentObject(userState)
            } else {
                BookSpudTabView()
                    .environmentObject(userState)
            }
        }
    }
}
