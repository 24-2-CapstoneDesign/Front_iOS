//
//  FriendConnectingLink.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import SwiftUI

/// 추천책 전체 뷰
struct BookRecommendView: View {
    
    @StateObject var bookRecommendViewModel: BookRecommendViewModel
    let data = sampleDataLists.datalist
    
    var body: some View {
        allView
    }
    
    // MARK: - BookRecommendView Components
    
    private var allView: some View {
        VStack(alignment: .center, spacing: 21, content: {
            HStack(content: {
                
                friendConnectingTitle
                
                Spacer()
            })
            //TODO: - 기본 뷰로 돌릴것
//            if let dataList = bookRecommendViewModel.friendConnecting?.information, !dataList.isEmpty {
            if !data.information.isEmpty {
                individualBookConnecting
            } else {
                EmptyBookView()
                notice
            }
        })
        .frame(maxWidth: 380, alignment: .center)
    }
    
    /// 독서 타이틀
    private var friendConnectingTitle: some View {
        Text("친구들의 독서 연결고리 📚")
            .font(.spoqaHans(type: .bold, size: 19))
            .foregroundStyle(Color.black)
    }
    
//    private var individualBookConnecting: some View {
//        ScrollView(.horizontal) {
//            LazyHGrid(rows: [GridItem(.flexible(minimum: 0, maximum: 150))], spacing: 40, content: {
//                ForEach(bookRecommendViewModel.friendConnecting?.information ?? [], id: \.self) { connectingData in
//                    ConnectingBookView(friendConnectingViewModel: FriendConnectingViewModel(friendConnectingDetailData: connectingData))
//                }
//            })
//        .frame(maxWidth: 390, maxHeight: 201)
//        .padding(.vertical, -10)
//        }
//    }
    
    private var individualBookConnecting: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible(minimum: 0, maximum: 150))], spacing: 40, content: {
                ForEach(data.information, id: \.self) { book in
                    BookRecommendCard(bookRecommendCardViewModel:BookRecommendCardViewModel(bookRecommendDetailData: book))
                }
            })
        }
        .frame(width: 390, height: 180)
        .padding(.vertical, -10)
    }
    
    /// 책 데이터 비었을 경우 안내글
    private var notice: some View {
        Text("등록된 독서 연결고리가 없습니다.")
            .font(.spoqaHans(type: .medium, size: 12))
            .kerning(-0.4)
            .foregroundStyle(Color.gray05)
    }
}

struct FriendConnectingLinkView_Preview: PreviewProvider {
    static var previews: some View {
        BookRecommendView(bookRecommendViewModel: BookRecommendViewModel())
            .previewLayout(.sizeThatFits)
    }
}
