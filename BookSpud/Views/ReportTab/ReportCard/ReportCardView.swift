//
//  ReportCardView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/5/24.
//

import SwiftUI

struct ReportCardView: View {
    
    @StateObject var viewModel: ReportCardViewModel
    
    var body: some View {
        allGroup
    }
    
    // MARK: - ReportCardView
    
    private var allGroup: some View {
        
        
        ZStack(alignment: .bottom, content: {
            
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white)
                .frame(width: 380, height: 142)
                .shadow03()
            
            HStack(alignment: .center, spacing: 19, content: {
                bookCoverView
                rightBookInfo
            })
            .frame(maxWidth: 322, maxHeight: 142, alignment: .top)
            .clipped()
            .onAppear {
                let urlString = "https://images.kbench.com/kbench/article/2015_05/k150016p1n17.jpg"
                if let url = URL(string: urlString) {
                    viewModel.loadImage(from: url)
                }
            }
        })
        .frame(width: 380, height: 142)
        
    }
    
    @ViewBuilder
    private var bookCoverView: some View {
        if let image = viewModel.bookCover {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 150, maxHeight: 224)
                .shadow03()
                .padding(.top, 20)
        } else {
            ProgressView()
                .frame(width: 100, height: 150)
        }
    }
    
    private var rightBookInfo: some View {
        VStack(alignment: .leading, spacing: 1, content: {
            ReportTagComponent(name: "초안")
            
            Text("아주 희미한 빛으로도")
                .font(.spoqaHans(type: .bold, size: 16))
                .foregroundStyle(Color.black)
                .frame(minWidth: 153, minHeight: 61, alignment: .topLeading)
            
                .padding(.top, 5)
          
            Text("2024.06.05")
                .font(.spoqaHans(type: .regular, size: 12))
                .foregroundStyle(Color.gray05)
                .kerning(-0.2)
            
            Spacer()
        })
        .frame(maxWidth: 153, minHeight: 190)
    }
}

struct ReportCardView_Preview: PreviewProvider {
    static var previews: some View {
        ReportCardView(viewModel: ReportCardViewModel())
            .previewLayout(.sizeThatFits)
    }
}
