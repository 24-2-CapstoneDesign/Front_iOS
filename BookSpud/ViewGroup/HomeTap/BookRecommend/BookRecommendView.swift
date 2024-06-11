//
//  FriendConnectingLink.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import SwiftUI

/// 추천책 전체 뷰
struct BookRecommendView: View {
    
    @ObservedObject var viewModel: BookRecommendViewModel
    @StateObject var bookRecommendCardViewModel: BookRecommendCardViewModel
    
    init(viewModel: BookRecommendViewModel) {
        self.viewModel = viewModel
        _bookRecommendCardViewModel = StateObject(wrappedValue: BookRecommendCardViewModel())
    }
    
    var body: some View {
        allView
            .onAppear {
                viewModel.getBookRecommend()
            }
    }
    
    // MARK: - BookRecommendView Components
    
    private var allView: some View {
        VStack(alignment: .center, spacing: 21, content: {
            HStack(content: {
                
                friendConnectingTitle
                
                Spacer()
            })
            if let data = viewModel.bookRecommendData?.result.myBooks {
                if !data.isEmpty {
                    individualBookConnecting
                }
            } else {
                EmptyBookView()
                notice
            }
        })
        .frame(maxWidth: 380, alignment: .center)
    }
    
    /// 독서 타이틀
    private var friendConnectingTitle: some View {
        Text("친구들의 독서 연결고리 📚")
            .font(.spoqaHans(type: .bold, size: 19))
            .foregroundStyle(Color.black)
    }
    
    /// 북투북 추천 책 리스트
    private var individualBookConnecting: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible(minimum: 0, maximum: 150))], spacing: 40, content: {
                ForEach(viewModel.bookRecommendData?.result.myBooks ?? [], id: \.self) { book in
                    NavigationLink(destination: BookRecommendDetailView(viewModel: bookRecommendCardViewModel, bookData: book)) {
                        BookRecommendCard(bookData: book)
                    }
                }
            })
            .frame(minWidth: 390, maxHeight: 210)
            .padding(.vertical, -10)
        }
    }
  
    
    /// 책 데이터 비었을 경우 안내글
    private var notice: some View {
        Text("등록된 독서 연결고리가 없습니다.")
            .font(.spoqaHans(type: .medium, size: 12))
            .kerning(-0.4)
            .foregroundStyle(Color.gray05)
    }
}
