//
//  ConnectingBookView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import SwiftUI

/// LazyGrid로 생성하는 북 카드
struct ConnectingBookView: View {
    
    @StateObject var friendConnectingViewModel: FriendConnectingViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 12, content: {
            friendConnectingViewModel.bookCover?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 100, maxHeight: 150)
                .shadow03()
            
            bookInfoText
        })
        .frame(maxWidth: 100, maxHeight: 191)
        .onAppear {
            friendConnectingViewModel.imageCacheHandler()
        }
    }
    
    private var bookInfoText: some View {
        VStack(alignment: .center, spacing: 3, content: {
            Text(friendConnectingViewModel.friendConnectingDetailData.bookName)
                .font(.spoqaHans(type: .bold, size: 12))
                .foregroundStyle(Color.mainText)
                .kerning(0.5)
                .lineSpacing(5)
                .frame(minWidth: 30)
            
            Text(friendConnectingViewModel.friendConnectingDetailData.author)
                .font(.spoqaHans(type: .regular, size: 9))
                .foregroundStyle(Color.subText)
                .kerning(0.2)
                .lineSpacing(5)
        })
    }
}

