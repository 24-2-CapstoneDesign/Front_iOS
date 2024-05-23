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
        leftBookCover
    }
    
    // MARK: - BookRecommendDetail Components
    
    private var leftBookCover: some View {
        VStack(alignment: .center, spacing: 11, content: {
            
            bookRecommendCardViewModel.bookCover?
                .resizable()
                .frame(maxWidth: 100, maxHeight: 150)
                .aspectRatio(contentMode: .fill)
            
            VStack(alignment: .center, spacing: 0, content: {
                Icon.emptyBookPoster.image
                    .fixedSize()
                GlobalMainBtn(clickBool: $bookRecommendCardViewModel.mainBtnCliked,
                              btnName: "구매하기",
                              btnImg: nil,
                              onClicked: bookRecommendCardViewModel.puerchaseBook
                )
            })
        })
    }
}



