//
//  SelectBookListView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/5/24.
//

import SwiftUI
import Kingfisher

/// 독후감 생성 전 책 표지 및 제목 데이터 보이기 위한 카드 뷰
struct SelectBookListCard: View {
    
    let bookData: BookListDetailData
    
    init(bookData: BookListDetailData) {
        self.bookData = bookData
    }
    
    var body: some View {
        bookInfo
    }
    
    // MARK: - SelectBookListView
    
    @ViewBuilder
    private var bookCover: some View {
        if let url = URL(string: bookData.cover) {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .frame(width: 180, height: 150)
                } .retry(maxCount: 2, interval: .seconds(2))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 100, maxHeight: 150)
                .clipShape(.rect(cornerRadius: 4))
                .shadow03()
        } else {
            ProgressView()
                .frame(width: 100, height: 150)
        }
    }
    
    private var bookInfo: some View {
        VStack(alignment: .center, spacing: 10, content: {
            bookCover
            
            VStack(alignment: .center, spacing: 3, content: {
                Text(bookData.title)
                    .font(.spoqaHans(type: .bold, size: 12))
                    .foregroundStyle(Color.mainText)
                    .lineLimit(1)
                Text(bookData.author)
                    .font(.spoqaHans(type: .regular, size: 10))
                    .foregroundStyle(Color.subText)
                    .lineLimit(1)
            })
        })
        .frame(maxWidth: 100, maxHeight: 190)
    }
}
