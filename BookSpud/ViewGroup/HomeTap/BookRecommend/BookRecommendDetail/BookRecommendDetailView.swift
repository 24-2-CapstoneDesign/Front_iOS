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
    @State var showSheet: Bool = false
    
    // MARK: - Main View
    var body: some View {
            VStack(alignment: .center, spacing: 50, content: {
                CustomNavigation(title: "책 정보")
                mainGroupView
                
                Spacer()
            })
            .ignoresSafeArea(.all)
            .navigationBarBackButtonHidden()
            .background(Color.backgrounYellow)
    }
    
    ///책정보 속 모든 정보 포함 그룹 뷰
    private var mainGroupView: some View {
        VStack(alignment: .center, spacing: 30, content: {
            topBookData
            bookMarkUserData
        })
        .frame(maxWidth: 382, maxHeight: 500)
        .padding(.top, 25)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .foregroundStyle(Color.white)
                .shadow03()
        )
    }
    
    /// 상단 책 정보 뷰
    private var topBookData: some View {
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
                .onAppear {
                    let urlString = viewModel.bookRecommendDetailData.cover
                    if let url = URL(string: urlString) {
                        viewModel.loadImage(from: url)
                    }
                }
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
                viewModel.purchaseBook()
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
            BookRecommendDetailRow(title: "도서명", value: viewModel.bookRecommendDetailData.title)
            BookRecommendDetailRow(title: "저     자", value: viewModel.bookRecommendDetailData.author)
            BookRecommendDetailRow(title: "정상가", value: self.formattedPrice(viewModel.individualBookData?.result.price ?? 0))
            BookRecommendDetailRow(title: "할인가", value: self.formattedPrice(viewModel.individualBookData?.result.salePrice ?? 0))
            BookRecommendDetailRow(title: "책소개", value: viewModel.individualBookData?.result.content ?? "책 소개 없음", hegiht: 63, alignment: .topLeading, onOff: true)
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
        VStack(alignment: .leading, spacing: 13, content: {
            
            Text("북마크 남긴 사람들 🔖")
                .font(.spoqaHans(type: .bold, size: 12))
                .foregroundStyle(Color.black)
                .kerning(-0.2)
            
            bookMarkProfileList
        })
        .onAppear {
            viewModel.getDataProfile(id: viewModel.bookRecommendDetailData.bookId)
        }
        .frame(maxWidth: 352, maxHeight: 249, alignment: .topLeading)
    }
    
    @ViewBuilder
    /// 북마크 프로필 리스트
    private var bookMarkProfileList: some View {
        
        if let emotionUserData = viewModel.emotionUserData {
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(minimum: 0, maximum: 150), spacing: 15), count: 6), spacing: 30,
                content: {
                    ForEach(emotionUserData.result, id: \.self) { data in
                    EmotionUserProfile(viewModel: EmotionUserViewModel(emotionUserDetailData: data))
                        .onTapGesture {
                            self.showSheet = true
                        }
                        .sheet(isPresented: $showSheet, content: {
                            CheckingUserBookMarkView(viewModel: CheckingUserBookMarkViewModel(checkingUserBookData: data),
                                                     isPresented: $showSheet)
                            .presentationDetents([.fraction(0.8)])
                            .presentationDragIndicator(.visible)
                        })
                        
                }
            })
            .frame(maxWidth: 352, alignment: .top)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            
        } else {
            HStack(content: {
                
                Spacer()
                
                VStack(alignment: .center, spacing: 16, content: {
                    Icon.sadSpud.image
                        .resizable()
                        .frame(maxWidth: 50, maxHeight: 53)
                    Text("등록된 북마크가 없습니다.")
                        .font(.spoqaHans(type: .regular, size: 10))
                        .foregroundStyle(Color.gray06)
                        .kerning(-0.2)
                })
                
                Spacer()
            })
            .frame(maxWidth: 352, maxHeight: 100)
        }
    }
}
