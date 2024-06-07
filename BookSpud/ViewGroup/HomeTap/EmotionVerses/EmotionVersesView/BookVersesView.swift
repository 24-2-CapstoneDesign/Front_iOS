//
//  BookVersesView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/18/24.
//

import SwiftUI

struct BookVersesView: View {
    
    @StateObject var viewModel: EmotionVersesViewModel
    
    var body: some View {
        viewGroup
    }
    
    // MARK: - ViewProperty
    
    private var viewGroup: some View {
        HStack(spacing: 1, content: {
            leftVerses
            rightBookPoster
        })
        .frame(maxWidth: 328, maxHeight: 150)
        .shadow03()
        .onAppear {
            viewModel.getVerses(emotion: "JOY")
        }
    }
    
    /// 왼쪽 구절 저장 뷰
    private var leftVerses: some View {
        ZStack(alignment: .center, content: {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.clear)
                .frame(maxWidth: 247, maxHeight: 150)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white, location: 0.9),
                            Gradient.Stop(color: Color(red: 0.95, green: 0.95, blue: 0.95), location: 1.00)
                        ],
                        startPoint: UnitPoint(x: 0, y: 0.5),
                        endPoint: UnitPoint(x: 1, y: 0.5)
                    )
                )
                .clipShape(.rect(cornerRadius: 8))
            
            if viewModel.bookVerses?.phase != nil{
                Icon.versesBorder.image
                    .fixedSize()
                    .aspectRatio(contentMode: .fit)
            }
            
            Text(viewModel.bookVerses?.phase ?? "저장한 구절이 없습니다.")
                .font(.gangwonEdu(type: .basic, size: 16))
                .foregroundStyle(Color.gray07)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 185, maxHeight: 62)
        })
    }
    
    private var rightBookPoster: some View {
        ZStack(alignment: .center, content: {
            
            RoundedCorner(radius: 8)
                .frame(maxWidth: 87, maxHeight: 150)
                .foregroundStyle(Color.white)
            
                bookPosterOrSprout
        })
        .onAppear {
            if let urlString = viewModel.bookVerses?.cover,
               let url = URL(string: urlString) {
                viewModel.loadImage(from: url)
            }
        }
    }
    
    @ViewBuilder
    /// 북포스터 또는 새싹 이미지 리턴
    private var bookPosterOrSprout: some View {
        if let bookPosterImg = viewModel.bookCover {
            if viewModel.isDefaultPosterImage {
                bookPosterImg
                    .fixedSize()
                    .aspectRatio(contentMode: .fit)
            } else {
                VStack(alignment: .center, content: {
                    bookPosterImg
                        .resizable()
                        .frame(maxWidth: 67, maxHeight: 100)
                        .aspectRatio(contentMode: .fit)
                    Text(viewModel.bookVerses?.title ?? "")
                        .font(.spoqaHans(type: .medium, size: 8))
                        .frame(minWidth: 45, minHeight: 10)
                        .foregroundStyle(Color.black)
                    
                    Spacer()
                    
                    Icon.emptyBookPoster.image
                        .fixedSize()
                })
                .frame(width: 67, height: 140)
                .padding(.top, 10)
            }
        }
        else {
            ProgressView()
        }
    }
}

struct BookVersesView_Previews: PreviewProvider {
    static let devices = ["iPhone 11", "iPhone 15 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { devices in
            BookVersesView(viewModel: EmotionVersesViewModel())
                .previewLayout(.sizeThatFits)
                .previewDisplayName(devices)
                .previewDevice(PreviewDevice(rawValue: devices))
        }
    }
}
