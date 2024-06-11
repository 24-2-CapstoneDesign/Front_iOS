//
//  CheckingUserBookMark.swift
//  BookSpud
//
//  Created by 정의찬 on 5/27/24.
//

import SwiftUI

/// 저장된 북마크 조회 뷰
struct BookMarkReadView: View {
    
    @StateObject var viewModel: BookMarkDetailViewModel
    let bookMardId: Int
    
    var body: some View {
            allView
        }
    
    init(bookMarkId: Int) {
        self._viewModel = StateObject(wrappedValue: BookMarkDetailViewModel())
        self.bookMardId = bookMarkId
    }
    
    // MARK: - CheckingUserBookMark View
    
    /// 북마크 상세 정보를 보는 뷰
    private var allView: some View {
        VStack(alignment: .center, spacing: 20, content: {
            title
            selectedPage
            selectedVerses
            writedMemo
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgrounYellow)
        .onAppear {
            viewModel.getBookMarkInfo(id: bookMardId)
        }
        .onDisappear {
            viewModel.bookMarkData = nil
        }
    }
    
    /// 유저들이 저장한 감정 북마크의 타이틀
    private var title: some View {
        HStack(spacing: 16, content: {
            Text("\(viewModel.userName)님의 감정")
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
    
    /// 북마크 저장된 책 페이지 수
    private var selectedPage: some View {
        HStack(alignment: .center, content: {
            Text("기록 페이지 💬")
                .font(.spoqaHans(type: .bold, size: 16))
                .kerning(-0.2)
                .foregroundStyle(Color.gray07)
            
            Spacer()
            
            
            ZStack(alignment: .center, content: {
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .frame(maxWidth: 78, maxHeight: 22)
                    .clipShape(.rect(cornerRadius: 4))
                    .shadow03()
                
                
                Text("\(viewModel.bookMarkData?.result.page ?? 0) 쪽")
                    .font(.spoqaHans(type: .regular, size: 12))
                    .foregroundStyle(Color.gray07)
            })
        })
        .frame(maxWidth: 339, maxHeight: 22)
    }
    
    /// 선택한 구절 보기
    private var selectedVerses: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("선택한 구절 💬")
                .font(.spoqaHans(type: .bold, size: 16))
                .kerning(-0.2)
                .foregroundStyle(Color.gray07)
            
            VersesBackground(versesText: viewModel.bookMarkData?.result.phase ?? "")
        })
    }
    
    /// 기록하고 싶은 메모 작성
    private var writedMemo: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("기록하고 싶은 메모 📝")
                .font(.spoqaHans(type: .bold, size: 16))
                .kerning(-0.2)
                .foregroundStyle(Color.gray07)
            
            WritedMemo(text: viewModel.bookMarkData?.result.memo ?? "")
        })
    }
}
