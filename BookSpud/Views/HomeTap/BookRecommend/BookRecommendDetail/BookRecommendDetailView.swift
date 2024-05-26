//
//  BookRecommendDetailView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/23/24.
//

import SwiftUI

/// 추천 받은 책 내부 정보 뷰
struct BookRecommendDetailView: View {
    
    @StateObject var viewModel: BookRecommendCardViewModel
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
        if let bookCover = viewModel.bookCover {
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
            BookRecommendDetailRow(title: "도서명", value: viewModel.bookRecommendDetailData.bookName)
            BookRecommendDetailRow(title: "저     자", value: viewModel.bookRecommendDetailData.author)
            BookRecommendDetailRow(title: "장     르", value: viewModel.bookRecommendDetailData.subject)
            BookRecommendDetailRow(title: "가     격", value: self.formattedPrice(viewModel.bookRecommendDetailData.price))
            BookRecommendDetailRow(title: "책소개", value: viewModel.bookRecommendDetailData.introduce, hegiht: 63, alignment: .top, onOff: true)
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
    
    // MARK: - BookRecommendDetail UserProfile
    /// 북마크 남긴 사람들
    private var bookMarkUserData: some View {
        HStack(alignment: .center, spacing: 13, content: {
            Text("북마크 남긴 사람들 🔖")
                .font(.spoqaHans(type: .bold, size: 12))
                .foregroundStyle(Color.black)
                .kerning(-0.2)
        })
    }
//    
//    private var bookMarkProfileList: some View {
//        LazyHGrid(rows: [GridItem(.flexible(minimum: 0, maximum: 100))], spacing: 8, content: {
//            ForEach(viewModel.emotionBookMardData?.information ?? [], id: \.self) { information in
//                
//            }
//        })
//    }
}
