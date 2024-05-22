//
//  NoRegistEmotion.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import SwiftUI

struct NoRegistEmotion: View {
    var body: some View {
        allViewGroup
    }
    
    // MARK: - Property
    
    private var allViewGroup: some View {
        ZStack(alignment: .center, content: {
            emptyBackgroundView
            noticeText
        })
        .frame(width: 334, height: 500)
    }
    
    /// 뒷 배경
    private var emptyBackgroundView: some View {
        Rectangle()
            .foregroundStyle(.clear)
            .frame(maxWidth: 334, minHeight: 500)
        
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .white.opacity(0.9), location: 0.00),
                        Gradient.Stop(color: Color(red: 1, green: 0.82, blue: 0.38).opacity(0.9), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
            )
            .clipShape(.rect(cornerRadius: 4))
    }
    
    private var noticeText: some View {
        VStack(alignment: .center, spacing: 19, content: {
            Text("등록된 감정이 없습니다!")
                .font(.spoqaHans(type: .bold, size: 20))
                .kerning(-0.2)
                .foregroundStyle(Color.gray06)
            Text("나의 감정 그래프를 보고 싶다면?")
                .font(.spoqaHans(type: .medium, size: 12))
                .kerning(-0.2)
                .foregroundStyle(Color.gray06)
            Button(action: {
                print("나의 감정 등록하러 가기")
            }, label: {
                Text("감정 등록하러 가기👉")
                    .frame(maxWidth: 173, maxHeight: 23)
                    .font(.spoqaHans(type: .bold, size: 12))
                    .kerning(-0.2)
                    .foregroundStyle(Color.gray06)
                    .background(
                        RoundedCorner()
                            .fill(Color.white)
                            .shadow03()
                    )
            })
        })
    }
}

struct NoRegistEmotion_Preview: PreviewProvider {
    static var previews: some View {
        NoRegistEmotion()
            .previewLayout(.sizeThatFits)
    }
}
