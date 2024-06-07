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
            let urlString = viewModel.bookRecommendDetailData.cover
            if let url = URL(string: urlString) {
                viewModel.loadImage(from: url)
            }
        }
    }
    
    // MARK: - BookRecommendCard Componenet
    
    /// 책 커버
    @ViewBuilder
    private var bookCoverImage: some View {
        if let image = viewModel.bookCover {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 100, minHeight: 150)
                .shadow03()
        } else {
            ProgressView()
                .frame(width: 100, height: 150)
        }
    }
    
    /// 책 이름 및 작가 이름
    private var bookInfoText: some View {
        VStack(alignment: .center, spacing: 3, content: {
            Text(viewModel.bookRecommendDetailData.title)
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

