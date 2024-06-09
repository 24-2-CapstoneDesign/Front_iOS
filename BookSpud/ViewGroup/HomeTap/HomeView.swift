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
    @EnvironmentObject var userState: UserState
    @StateObject var emotionVersesViewModel = EmotionVersesViewModel()
    @StateObject var bookCommendViewModel = BookRecommendViewModel()
    @StateObject var emotionChartViewModel = EmotionChartViewModel()

    
    var body: some View {
        NavigationStack {
            allView
                .onAppear {
                    userState.loadUserName()
                    userState.loadUserProfile()
                }
        }
    }
    
    /// 홈탭 뷰 모든 뷰 그룹
    private var allView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 29, content: {
                
                /* 상단 유저 프로필 정보 */
                TopUserComponent()
                    .environmentObject(userState)
                
                /* 감정 구절 랜덤 뷰 */
                EmotionVersesView(viewModel: emotionVersesViewModel)
                
                MainDotLine
                
                /* 북투북 북투유저 책 추천 뷰*/
                BookRecommendView(viewModel: bookCommendViewModel)
                
                MainDotLine
                
                EmotionChartView(viewModel: emotionChartViewModel)
                    .environmentObject(userState)
            })
            .frame(minHeight: 1390, maxHeight: .infinity, alignment: .top).ignoresSafeArea(.all)
            .background(Color.backgrounYellow)
        }
        .background(Color.backgrounYellow)
        .ignoresSafeArea(.all)
        
    }
    
    private var MainDotLine: some View {
        BookSpud.MainDotLine()
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [2, 3]))
            .frame(width: 390, height: 1)
            .foregroundStyle(Color.gray04)
    }
}
