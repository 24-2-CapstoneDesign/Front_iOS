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
                let urlString = viewModel.bookListDetailData.bookCover
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
        if let image = viewModel.image {
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
            Text(viewModel.bookListDetailData.bookName.split(separator: "").joined(separator: "\u{200B}"))
                .font(.spoqaHans(type: .regular, size: 10))
                .kerning(-0.2)
                .foregroundStyle(Color.mainText)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .lineSpacing(1.5)
                .frame(maxWidth: 100, maxHeight: 37)
                .padding(.vertical, -5)
            
            Text(viewModel.bookListDetailData.bookAuthor)
                .font(.spoqaHans(type: .regular, size: 10))
                .kerning(-0.2)
                .foregroundStyle(Color.subText)
                .frame(maxWidth: 100, maxHeight: 12)
        })
        .frame(maxWidth: 100, maxHeight: 53)
    }
}

struct BookListCardView_Preview: PreviewProvider {
    static var previews: some View {
        BookListCardView(viewModel: BookListCardViewModel(bookListDetailData: BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788954695053.jpg", bookName: "아주 희미안 빛으로도", bookAuthor: "최은영", bookCurrentPage: 324, bookTotalPage: 324, bookMarkCount: 24)))
            .previewLayout(.sizeThatFits)
    }
}
