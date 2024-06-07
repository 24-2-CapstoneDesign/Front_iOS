//
//  SelectBookListView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/5/24.
//

import SwiftUI

/// 독후감 뷰에서 독후감 추가 시 책 선택
struct SelectBookListCard: View {
    
    @StateObject var viewModel: IndividualSelectBookViewModel
    
    var body: some View {
        bookInfo
    }
    
    // MARK: - SelectBookListView
    
    @ViewBuilder
    private var bookCover: some View {
        if let image = viewModel.bookCover {
            image
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
                Text(viewModel.data.title)
                    .font(.spoqaHans(type: .bold, size: 12))
                    .foregroundStyle(Color.mainText)
                    .lineLimit(1)
                Text(viewModel.data.author)
                    .font(.spoqaHans(type: .regular, size: 10))
                    .foregroundStyle(Color.subText)
                    .lineLimit(1)
            })
        })
        .frame(maxWidth: 100, maxHeight: 190)
        .onAppear {
            let urlString = viewModel.data.cover
            if let url = URL(string: urlString) {
                viewModel.loadImage(from: url)
            }
        }
    }
}
