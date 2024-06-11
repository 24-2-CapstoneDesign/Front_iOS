//
//  SuccessISBN.swift
//  BookSpud
//
//  Created by 정의찬 on 5/30/24.
//

import SwiftUI

struct SuccessISBN: View {
    
    @ObservedObject var viewModel: ISBNInputViewModel
    
    var body: some View {
        VStack(alignment: .center, content: {
            
            Spacer().frame(maxHeight: 20)
            
            VStack(alignment: .center, spacing: 20, content: {
                HStack(spacing: 25, content: {
                    bookCover
                    divideLine
                    bookInfo
                })
                .frame(maxWidth: 342, maxHeight: 210)
                
                saveButton
                
            })
            .frame(maxWidth: .infinity)
            
           Spacer()
        })
        .background(Color.backgrounYellow)
    }
    
    // MARK: - BookInforView
    
    @ViewBuilder
    private var bookCover: some View {
        if let urlString = viewModel.scanBookData?.documents.first?.thumbnail, let url = URL(string: urlString) {
            AsyncImage(url: url) { image in
                switch image {
                case .empty:
                    ProgressView()
                case .success(let img):
                    img
                        .resizable()
                        .frame(maxWidth: 120, maxHeight: 170)
                        .aspectRatio(contentMode: .fit)
                case .failure(_):
                    EmptyBookView()
                @unknown default:
                    EmptyBookView()
                }
            }
        } else {
            EmptyBookView()
        }
    }
    
    /// 책 커버와 책 정보 사이 구분선
    private var divideLine: some View {
        Divider()
            .frame(maxWidth: 1, maxHeight: 160)
            .background(Color.primary1)
    }
    
    /// 오른쪽 책 정보
    private var bookInfo: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            BookRecommendDetailRow(title: "도서명", value: viewModel.scanBookData?.documents.first?.title ?? "책 정보 없음")
            BookRecommendDetailRow(title: "저     자", value: viewModel.scanBookData?.documents.first?.authors.first ?? "작가 정보 없음")
            BookRecommendDetailRow(title: "정상가", value: self.formattedPrice(viewModel.scanBookData?.documents.first?.price ?? 0))
            BookRecommendDetailRow(title: "할인가", value: self.formattedPrice(viewModel.scanBookData?.documents.first?.salePrice ?? 0))
            BookRecommendDetailRow(title: "책소개", value: viewModel.scanBookData?.documents.first?.contents ?? "책 소개 내용 없음", hegiht: 80, alignment: .topLeading, onOff: true)
        })
        .frame(maxWidth: 224, maxHeight: 220, alignment: .bottom)
    }
    
    private var saveButton: some View {
        VStack(alignment: .center, spacing: -4, content: {
            Icon.emptyBookPoster.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 60)
            
            Button(action: {
                viewModel.sendBookInfo()
                viewModel.isShowSaveView = false
            }, label: {
                Text("저장하기")
                    .font(.spoqaHans(type: .bold, size: 12))
                    .kerning(-0.2)
                    .foregroundStyle(Color.gray07)
                    .frame(maxWidth: 259, maxHeight: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.primary1)
                    )
                    .shadow03()
            })
            .frame(maxWidth: 259, maxHeight: 32)
        })
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

struct SuccessISBN_Preview: PreviewProvider {
    static var previews: some View {
        SuccessISBN(viewModel: ISBNInputViewModel())
    }
}
