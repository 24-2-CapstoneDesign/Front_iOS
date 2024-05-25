//
//  BookRecommendDetailView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/23/24.
//

import SwiftUI

struct BookRecommendDetailView: View {
    
    @StateObject var bookRecommendCardViewModel: BookRecommendCardViewModel
    
    // MARK: - Property
    var body: some View {
        leftBookInfo
    }
    
    // MARK: - BookRecommendDetail Cover and PurchaseBtn
    
    
    /// 왼쪽 북마크 책정보(책 표지 + 구입 링크)
    private var leftBookInfo: some View {
        VStack(alignment: .center, spacing: 11, content: {
            bookCover
            purchaseBtn
        })
        .frame(maxWidth: 102, maxHeight: 193)
    }
    
    @ViewBuilder
    /// 책 표지
    private var bookCover: some View {
        if let bookCover = bookRecommendCardViewModel.bookCover {
            bookCover
                .resizable()
                .frame(maxWidth: 100, maxHeight: 150)
                .aspectRatio(contentMode: .fill)
                .shadow03()
        } else {
            EmptyBookView()
        }
    }
    
    /// 책 구매하기 버튼
    private var purchaseBtn: some View {
        VStack(alignment: .center, spacing: -4, content: {
            Icon.emptyBookPoster.image
                .fixedSize()
            
            Button(action: {
                print("구매 버튼 누름")
            }, label: {
                Text("구매하기")
                    .font(.spoqaHans(type: .bold, size: 12))
                    .kerning(-0.2)
                    .foregroundStyle(Color.gray07)
                    .frame(maxWidth: 102, maxHeight: 23)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.primary1)
                    )
                    .shadow03()
            })
            .frame(maxWidth: 102, maxHeight: 32)
        })
    }
    
    // MARK: - BookRecommendDetail Info
    
    private var boookDetailInfo: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            HStack(alignment: .center, spacing: 11, content: {
                /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
            })
        })
    }
}

struct BookRecommendDetailView_Preview: PreviewProvider {
    static var previews: some View {
        BookRecommendDetailView(bookRecommendCardViewModel: BookRecommendCardViewModel(bookRecommendDetailData: BookRecommendDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791168418011.jpg", bookName: "Book One", author: "Author A")))
    }
}



