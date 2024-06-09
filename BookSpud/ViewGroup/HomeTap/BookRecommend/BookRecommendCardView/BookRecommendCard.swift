//
//  ConnectingBookView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import SwiftUI
import Kingfisher

/// LazyGrid로 생성하는 북 카드
struct BookRecommendCard: View {
    
    let bookData: BookRecommendDetailData
    
    init(bookData: BookRecommendDetailData) {
        self.bookData = bookData
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 12, content: {
            bookCoverImage
            bookInfoText
        })
        .frame(maxWidth: 100, maxHeight: 200)
    }
    
    // MARK: - BookRecommendCard Componenet
    
    /// 추천 책 커버
    @ViewBuilder
    private var bookCoverImage: some View {
        if let bookCoverUrl = URL(string: bookData.cover) {
            KFImage(bookCoverUrl)
                .placeholder {
                    ProgressView()
                        .frame(width: 100, height: 150)
                }.retry(maxCount: 3, interval: .seconds(2))
                .onSuccess { r in
                    print("추천 책표시 이미지 로딩 성공: \(r)")
                }
                .onFailure { r in
                    print("추천 책표시 이미지 로딩 성공: \(r)")
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 100, minHeight: 150)
                .shadow03()
        }
    }
    
    /// 책 이름 및 작가 이름
    private var bookInfoText: some View {
        VStack(alignment: .center, spacing: 3, content: {
            Text(bookData.title)
                .font(.spoqaHans(type: .bold, size: 12))
                .foregroundStyle(Color.mainText)
                .kerning(0.5)
                .lineSpacing(5)
                .frame(minWidth: 30)
            
            Text(bookData.author)
                .font(.spoqaHans(type: .regular, size: 9))
                .foregroundStyle(Color.subText)
                .kerning(0.2)
                .lineSpacing(5)
        })
    }
}

