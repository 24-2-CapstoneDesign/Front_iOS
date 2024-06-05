//
//  EmotionUserProfile.swift
//  BookSpud
//
//  Created by 정의찬 on 5/26/24.
//

import SwiftUI

/// 유저 프로필 카드(북마크를 남긴 사람들 컴포넌트 사용)
struct EmotionUserProfile: View {
    
    @StateObject var viewModel: EmotionUserViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 8, content: {
            userProfile
            userName
        })
        .frame(maxWidth: 52, maxHeight: 109)
        .onAppear {
            viewModel.userDataInfoUpdate()
        }
    }
    
    // MARK: - EmotionUserDataView
    
    private var userProfile: some View {
        viewModel.emotionUserProfile
            .resizable()
            .frame(maxWidth: 44, maxHeight: 44)
            .aspectRatio(contentMode: .fill)
            .background(Color(red: 0.56, green: 0.56, blue: 0.56).opacity(0.3))
            .clipShape(Circle())
    }
    
    private var userName: some View {
        Text(viewModel.emotionUserDetailData?.bookMarkName ?? "유저 닉네임 정보 없음")
            .font(.spoqaHans(type: .medium, size: 12))
            .kerning(-0.2)
            .frame(maxWidth: 44, minHeight: 30, alignment: .top)
            .lineLimit(nil)
            .foregroundStyle(Color.gray07)
    }
}
