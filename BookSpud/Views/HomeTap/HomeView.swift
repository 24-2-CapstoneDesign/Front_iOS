//
//  HomeView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/11/24.
//

import SwiftUI

/// 홈탭 모든 뷰 구성
struct HomeView: View {
    
    // MARK: - ViewModel
    @StateObject var topUserViewModel = TopUserViewModel()
    @StateObject var emotionVersesViewModel = EmotionVersesViewModel()
    @StateObject var friendConnectingLinkViewModel = FriendConnectingLinkViewModel()
    
    var body: some View {
        allView
    }
    
    /// 홈탭 뷰 모든 뷰 그룹
    private var allView: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 29, content: {
                TopUserView(topUserViewModel: topUserViewModel)
                
                EmotionVersesView(emotionVersesViewModel: EmotionVersesViewModel())
                
                MainDotLine
                
                FriendConnectingLinkView(friendConnectingLinkViewModel: friendConnectingLinkViewModel)
                
                MainDotLine
                    
            })
        }
        .ignoresSafeArea(.all)
    }
    
    private var MainDotLine: some View {
        BookSpud.MainDotLine()
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [2, 3]))
            .frame(width: 390, height: 1)
            .foregroundStyle(Color.gray04)
    }
}

struct HomeView_Preview: PreviewProvider {
    static let devices = ["iPhone 11", "iPhone 15 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            HomeView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
