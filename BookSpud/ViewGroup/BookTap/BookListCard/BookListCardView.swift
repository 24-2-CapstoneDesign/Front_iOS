//
//  BookListCardView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/2/24.
//

import SwiftUI

struct BookListCardView: View {
    
    @StateObject var viewModel: BookListCardViewModel
    
    var body: some View {
        ZStack(alignment: .center, content: {
            backgroundCardView
            VStack(alignment: .center, spacing: 12, content: {
                bookCoverView
                bookInfoView
                BookReadProgressView(viewModel: viewModel)
            })
            .frame(minWidth: 130, maxHeight: 245)
            .onAppear {
                let urlString = viewModel.bookListDetailData.cover
                if let url = URL(string: urlString) {
                    viewModel.loadImage(from: url)
                }
            }
        })
    }
    
    // MARK: - BookListCardView
    
    /// 서버 백그라운드 서버
    private var backgroundCardView: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(
                Color.white
            )
            .frame(width: 181, height: 285)
            .shadow03()
    }
    
    @ViewBuilder
    /// 책 커버 사진
    private var bookCoverView: some View {
        if let image = viewModel.authorImage {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 100, maxHeight: 150)
                .shadow02()
        } else {
            ProgressView()
                .frame(maxWidth: 100, maxHeight: 150)
        }
    }
    
    /// 책 제목 및 작가
    private var bookInfoView: some View {
        VStack(alignment: .center, spacing: 6, content: {
            Text(viewModel.bookListDetailData.title.split(separator: "").joined(separator: "\u{200B}"))
                .font(.spoqaHans(type: .regular, size: 10))
                .kerning(-0.2)
                .foregroundStyle(Color.mainText)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .lineSpacing(1.5)
                .frame(maxWidth: 100, maxHeight: 37)
                .padding(.vertical, -5)
            
            Text(viewModel.bookListDetailData.author)
                .font(.spoqaHans(type: .regular, size: 10))
                .kerning(-0.2)
                .foregroundStyle(Color.subText)
                .frame(maxWidth: 100, maxHeight: 12)
        })
        .frame(maxWidth: 100, maxHeight: 53)
    }
}
