//
//  CheckingUserBookMark.swift
//  BookSpud
//
//  Created by 정의찬 on 5/27/24.
//

import SwiftUI

/// 북마크를 남긴 사람들의 북마크 클릭시 감정 Sheet뷰
struct CheckingUserBookMarkView: View {
    
    @StateObject var viewModel: CheckingUserBookMarkViewModel
    @Binding var isPresented: Bool
    
    init(
         isPresented: Binding<Bool>,
         data: EmotionUserDetailData
    ) {
        self._viewModel = StateObject(wrappedValue: CheckingUserBookMarkViewModel(checkingUserBookData: data))
        self._isPresented = isPresented
    }
    
    var body: some View {
        allView
    }
    
    // MARK: - CheckingUserBookMark View
    
    /// 북마크 상세 정보를 보는 뷰
    private var allView: some View {
        VStack(alignment: .center, spacing: 20, content: {
            
            Spacer()
            
            title
            selectedVerses
            writedMemo
            
            Spacer()
        })
        .frame(maxWidth: .infinity)
        .background(Color.backgrounYellow)
        .onAppear {
            if isPresented {
                viewModel.emotionImageChange(viewModel.checkingUserBookData.emotion)
            }
        }
    }
    
    /// 유저들이 저장한 감정 북마크의 타이틀
    private var title: some View {
        HStack(spacing: 16, content: {
            Text("\(viewModel.checkingUserBookData.nickName)님의 감정")
                .font(.spoqaHans(type: .bold, size: 20))
                .kerning(-0.2)
                .foregroundStyle(Color.gray06)
            
            ZStack(content: {
                Icon.emotionBackground.image
                    .resizable()
                    .frame(maxWidth: 147, maxHeight: 32)
                    .aspectRatio(contentMode: .fit)
                
                HStack(alignment: .center, spacing: 6, content: {
                    viewModel.emotionImg
                        .resizable()
                        .frame(maxWidth: 26, maxHeight: 27)
                        .aspectRatio(contentMode: .fit)
                    
                    viewModel.emotionTextImg
                        .resizable()
                        .frame(maxWidth: 57, maxHeight: 32)
                        .aspectRatio(contentMode: .fit)
                })
            })
            .frame(maxWidth: 147, maxHeight: 32)
        })
    }
    
    /// 선택한 구절 보기
    private var selectedVerses: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("선택한 구절 💬")
                .font(.spoqaHans(type: .bold, size: 16))
                .kerning(-0.2)
                .foregroundStyle(Color.gray07)
            
            VersesBackground(versesText: viewModel.checkingUserBookData.phase)
        })
    }
    
    /// 기록하고 싶은 메모 작성
    private var writedMemo: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("기록하고 싶은 메모 📝")
                .font(.spoqaHans(type: .bold, size: 16))
                .kerning(-0.2)
                .foregroundStyle(Color.gray07)
            
            WritedMemo(text: viewModel.checkingUserBookData.memo)
        })
    }
}
