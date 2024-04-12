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
    
    init() {
            // Kakao SDK 초기화
            KakaoSDK.initSDK(appKey: "f9fd82c29e5a60c4c9a3c70fd938deda")
        }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
            
        }
    }
}
