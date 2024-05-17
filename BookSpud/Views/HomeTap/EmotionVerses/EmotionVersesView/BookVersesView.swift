//
//  BookVersesView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/18/24.
//

import SwiftUI

struct BookVersesView: View {
    
    @StateObject var emotionVersesViewModel: EmotionVersesViewModel
    
    var body: some View {
        leftVerses
    }
    
    // MARK: - ViewProperty
    
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
                .shadow03()
            
            if emotionVersesViewModel.bookVerses?.verses != nil{
                Icon.versesBorder.image
                    .fixedSize()
                    .aspectRatio(contentMode: .fit)
            }
            
            
            Text(emotionVersesViewModel.bookVerses?.verses ?? "저장한 구절이 없습니다.")
                .font(.gangwonEdu(type: .basic, size: 16))
                .foregroundStyle(Color.gray07)
                .multilineTextAlignment(.center)
                .lineLimit(0)
        })
    }
    
    //TODO: Right뷰 생성하기
}

struct BookVersesView_Previews: PreviewProvider {
    static let devices = ["iPhone 11", "iPhone 15 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { devices in
            BookVersesView(emotionVersesViewModel: EmotionVersesViewModel())
                .previewLayout(.sizeThatFits)
                .previewDisplayName(devices)
                .previewDevice(PreviewDevice(rawValue: devices))
        }
    }
}
