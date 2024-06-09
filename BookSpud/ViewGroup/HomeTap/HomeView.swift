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
                TopUserComponent()
                    .environmentObject(userState)
                
                EmotionVersesView(viewModel: emotionVersesViewModel)
                
                MainDotLine
                
                BookRecommendView(viewModel: bookCommendViewModel)
                
                MainDotLine
                
                EmotionChartView(viewModel: emotionChartViewModel)
            })
            .frame(minHeight: 1405, maxHeight: .infinity, alignment: .top).ignoresSafeArea(.all)
            .background(Color.backgrounYellow)
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
