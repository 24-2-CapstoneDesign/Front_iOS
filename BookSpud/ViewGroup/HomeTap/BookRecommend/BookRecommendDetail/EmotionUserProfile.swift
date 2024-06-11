//
//  EmotionUserProfile.swift
//  BookSpud
//
//  Created by 정의찬 on 5/26/24.
//

import SwiftUI
import Kingfisher

/// 유저 프로필 카드(북마크를 남긴 사람들의 북마크 컴포넌트)
struct EmotionUserProfile: View {
    
    let emotionUserDetailData: EmotionUserDetailData
    @State var showSheet: Bool
    
    // MARK: - init
    
    init(emotionUserDetailData: EmotionUserDetailData) {
        self.emotionUserDetailData = emotionUserDetailData
        self.showSheet = false
    }
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 8, content: {
            userProfile
            userName
        })
        .onTapGesture {
            showSheet = true
        }
        .frame(maxWidth: 52, maxHeight: 109)
        .sheet(isPresented: $showSheet, content: {
            CheckingUserBookMarkView(isPresented: $showSheet, data: emotionUserDetailData)
            .presentationDetents([.fraction(0.8)])
            .presentationDragIndicator(.visible)
        })
    }
    
    // MARK: - EmotionUserDataView
    
    @ViewBuilder
    /// 유저 프로필 정보
    private var userProfile: some View {
        if let url = URL(string: emotionUserDetailData.profileImageUrl) {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .frame(width: 44, height: 44)
                }.retry(maxCount: 2, interval: .seconds(2))
                .resizable()
                .frame(maxWidth: 44, maxHeight: 44)
                .aspectRatio(contentMode: .fill)
                .background(Color(red: 0.56, green: 0.56, blue: 0.56).opacity(0.3))
                .clipShape(Circle())
        }
    }
    
    /// 유저 닉네임 정보
    private var userName: some View {
        Text(emotionUserDetailData.nickName)
            .font(.spoqaHans(type: .medium, size: 12))
            .kerning(-0.2)
            .frame(maxWidth: 44, minHeight: 30, alignment: .top)
            .lineLimit(nil)
            .foregroundStyle(Color.gray07)
    }
}
