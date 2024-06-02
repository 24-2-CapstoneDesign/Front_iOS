//
//  BookListCardView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/2/24.
//

import SwiftUI

struct BookListCardView: View {
    
    @StateObject var viewModel: BookListCardViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    // MARK: - BookListCardView
    
    /// 서버 백그라운드 서버
    private var backgroundCardView: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(
                Color.white
            )
            .frame(width: 181, height: 285)
            .shadow03()
    }
    
    @ViewBuilder
    private var bookCoverView: some View {
        if let image = viewModel.image {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 100, maxHeight: 150)
        } else {
            ProgressView()
                .frame(maxWidth: 100, maxHeight: 150)
        }
    }
}
