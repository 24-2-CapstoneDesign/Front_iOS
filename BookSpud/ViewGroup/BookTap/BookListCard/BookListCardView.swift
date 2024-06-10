//
//  BookListCardView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/2/24.
//

import SwiftUI
import Kingfisher

/// 내가 저장한 책 정보 담는 카드 뷰
struct BookListCardView: View {
    
    let bookData: BookListDetailData
    @State var isClickedView: Bool
    
    init(bookData: BookListDetailData, isClickedView: Bool = false) {
        self.bookData = bookData
        self.isClickedView = isClickedView
    }
    
    var body: some View {
        NavigationLink(destination: BookListDetailView(bookData: bookData)) {
            carViewGroup
        }
    }
    
    // MARK: - BookListCardView
    
    private var carViewGroup: some View {
        ZStack(alignment: .center, content: {
            backgroundCardView
            VStack(alignment: .center, spacing: 12, content: {
                bookCoverView
                bookInfoView
                BookReadProgressView(bookData: self.bookData)
            })
            .frame(minWidth: 130, maxHeight: 245)
        })
    }
    
    /// 책 정보 배경뷰
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
        if let url = URL(string: bookData.cover) {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .frame(width: 100, height: 150)
                } .retry(maxCount: 2, interval: .seconds(2))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 100, maxHeight: 150)
                .shadow02()
        } else {
            EmptyBookView()
        }
    }
    
    //TODO: - 추후 복습 코드
    
    /// 책 제목 및 작가
    private var bookInfoView: some View {
        VStack(alignment: .center, spacing: 6, content: {
            Text(bookData.title.split(separator: "").joined(separator: "\u{200B}"))
                .font(.spoqaHans(type: .regular, size: 10))
                .kerning(-0.2)
                .foregroundStyle(Color.mainText)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .lineSpacing(1.5)
                .frame(maxWidth: 100, maxHeight: 37)
                .padding(.vertical, -5)
            
            Text(bookData.author)
                .font(.spoqaHans(type: .regular, size: 10))
                .kerning(-0.2)
                .foregroundStyle(Color.subText)
                .frame(maxWidth: 100, maxHeight: 12)
        })
        .frame(maxWidth: 100, maxHeight: 53)
    }
}
