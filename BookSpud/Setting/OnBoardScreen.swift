//
//  OnBoardScreen.swift
//  BookSpud
//
//  Created by 정의찬 on 6/4/24.
//

import SwiftUI
import AVFoundation

struct OnBoardScreen: View {
    @State private var isVisible: Bool = false
    @Binding var hasScreenOnboard: Bool
    @State private var showingCameraAlert = false

    var body: some View {
        VStack(alignment: .center, spacing: 5, content: {
            Spacer()
            
            Icon.logo.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 200)
            
            Text("Book Spud")
                .font(.spoqaHans(type: .bold, size: 26))
                .foregroundStyle(Color.mainText)
            
            Text("독서, 무한한 지식의 여정을 시작하세요!")
                .font(.spoqaHans(type: .medium, size: 16))
                .foregroundStyle(Color.subText)
            
            Spacer()
        })
        .opacity(isVisible ? 1 : 0)
        .onAppear {
            withAnimation(.easeIn(duration: 1)) {
                isVisible = true
            }
            showingCameraAlert = true
        }
        .onDisappear {
            withAnimation(.easeOut(duration: 1)) {
                isVisible = false
            }
        }
        .alert("카메라 허용", isPresented: $showingCameraAlert) {
            Button("허용", role: .none) {
                requestCameraAccess()
            }
            Button("거절", role: .cancel) {
                
            }
        } message: {
            Text("책을 저장하고 책의 내용을 사용하기 위해 카메라 접근 권한이 필요합니다.")
        }
    }
    
    private func requestCameraAccess() {
        AVCaptureDevice.requestAccess(for: .video) { response in
            if response {
                DispatchQueue.main.async {
                    hasScreenOnboard = true
                }
            } else {
                hasScreenOnboard = false
            }
        }
    }
}
