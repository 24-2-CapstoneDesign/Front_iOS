//
//  BookRecommendDetailView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/23/24.
//

import SwiftUI

/// 추천 받은 책 내부 정보 뷰
struct BookRecommendDetailView: View {
    
    @StateObject var bookRecommendCardViewModel: BookRecommendCardViewModel
    let data = sampleDataLists.datalist
    
    // MARK: - Property
    var body: some View {
        allGroupView
    }
    
    // MARK: - AllView
    
    private var allGroupView: some View {
        HStack(spacing: 14, content: {
            leftBookInfo
            
            Divider()
                .frame(width: 1, height: 197)
                .background(Color.primary1)
            
            bookDetailInfo
        })
        .frame(maxWidth: 342, maxHeight: 197)
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
    
    /// 오른쪽 책 정보 뷰
    private var bookDetailInfo: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            BookRecommendDetailRow(title: "도서명", value: bookRecommendCardViewModel.bookRecommendDetailData.bookName)
            BookRecommendDetailRow(title: "저     자", value: bookRecommendCardViewModel.bookRecommendDetailData.author)
            BookRecommendDetailRow(title: "장     르", value: bookRecommendCardViewModel.bookRecommendDetailData.subject)
            BookRecommendDetailRow(title: "가     격", value: self.formattedPrice(bookRecommendCardViewModel.bookRecommendDetailData.price))
            BookRecommendDetailRow(title: "책소개", value: bookRecommendCardViewModel.bookRecommendDetailData.introduce, hegiht: 63, alignment: .top, onOff: true)
        })
        .frame(maxWidth: 224, maxHeight: 197)
    }
    
    /// 가격에 대해 x,xx원 표시
    /// - Parameter price: 데이터로 전달받은 책 가격
    /// - Returns: 가격 표시
    private func formattedPrice(_ price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) {
            return "\(formattedPrice) 원"
        }
        return "\(price) 원"
    }
}

struct BookRecommendDetailView_Preview: PreviewProvider {
    static var previews: some View {
        BookRecommendDetailView(bookRecommendCardViewModel: BookRecommendCardViewModel(bookRecommendDetailData: BookRecommendDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791168418011.jpg", bookName: "Book One", author: "Author A", subject: "소설", price: 12800, introduce: "하하하하하 재밌어요asdkhajdhasdjhaskdhakdhasjkdhajksdhasjkdhakjsdhkasjdhakjdhaskdajsdhjdhakjsdhkdhksdhskjdhsakj!!")))
    }
}


