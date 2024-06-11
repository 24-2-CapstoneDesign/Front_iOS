//
//  BookVersesView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/18/24.
//

import SwiftUI
import Kingfisher

struct BookVersesView: View {
    
    @ObservedObject var viewModel: EmotionVersesViewModel
    
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
            
            if viewModel.bookVersesData?.phase != nil{
                Icon.versesBorder.image
                    .fixedSize()
                    .aspectRatio(contentMode: .fit)
            }
            
            Text(viewModel.bookVersesData?.phase ?? "저장한 구절이 없습니다.")
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
        
    }
    
    @ViewBuilder
    /// 랜덤 구절 책 표지 Url로 받아오기
    private var bookPosterOrSprout: some View {
        if let urlString = viewModel.bookVersesData?.cover,
           let bookCoverUrl = URL(string: urlString) {
            VStack(alignment: .center, content: {
                KFImage(bookCoverUrl)
                    .placeholder {
                        ProgressView()
                            .frame(width: 67, height: 100)
                    }.retry(maxCount: 3, interval: .seconds(2))
                    .onSuccess { r in
                        print("랜덤 구절 책표지 이미지 로딩 성공: \(r)")
                    }
                    .onFailure { r in
                        print("랜덤 구절 책표지 이미지 로딩 실패: \(r)")
                    }
                    .resizable()
                    .frame(maxWidth: 67, maxHeight: 100)
                    .aspectRatio(contentMode: .fit)
                Text(viewModel.bookVersesData?.title ?? "")
                    .font(.spoqaHans(type: .medium, size: 8))
                    .frame(minWidth: 45, minHeight: 10)
                    .foregroundStyle(Color.black)
                
                Spacer()
                
                Icon.emptyBookPoster.image
                    .fixedSize()
            })
            .frame(width: 67, height: 140)
            .padding(.top, 10)
        }  else {
            Icon.emptyBookPoster.image
                .fixedSize()
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
