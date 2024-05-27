//
//  ConnectingBookView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import SwiftUI

/// LazyGrid로 생성하는 북 카드
struct BookRecommendCard: View {
    
    @StateObject var viewModel: BookRecommendCardViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 12, content: {
            bookCoverImage
            bookInfoText
        })
        .frame(maxWidth: 100, maxHeight: 191)
        .onAppear {
            viewModel.imageCacheHandler()
        }
    }
    
    // MARK: - BookRecommendCard Componenet
    
    /// 책 커버
    private var bookCoverImage: some View {
        viewModel.bookCover?
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 100, maxHeight: 150)
            .shadow03()
    }
    
    /// 책 이름 및 작가 이름
    private var bookInfoText: some View {
        VStack(alignment: .center, spacing: 3, content: {
            Text(viewModel.bookRecommendDetailData.bookName)
                .font(.spoqaHans(type: .bold, size: 12))
                .foregroundStyle(Color.mainText)
                .kerning(0.5)
                .lineSpacing(5)
                .frame(minWidth: 30)
            
            Text(viewModel.bookRecommendDetailData.author)
                .font(.spoqaHans(type: .regular, size: 9))
                .foregroundStyle(Color.subText)
                .kerning(0.2)
                .lineSpacing(5)
        })
    }
}

