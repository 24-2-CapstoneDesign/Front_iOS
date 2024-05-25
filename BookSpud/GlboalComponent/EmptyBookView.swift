//
//  EmptyBookView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/23/24.
//

import SwiftUI

struct EmptyBookView: View {
    var body: some View {
        /// 책 데이터 비었을 경우 표시 포스터
        ZStack(alignment: .center, content: {
            Rectangle()
                .foregroundStyle(.clear)
                .frame(maxWidth: 100, maxHeight: 150)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white, location: 0.00),
                            Gradient.Stop(color: Color(red: 0.97, green: 0.81, blue: 0.27), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )
                .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
            
            
            Text("!")
                .font(.spoqaHans(type: .medium, size: 40))
                .kerning(-0.4)
                .foregroundStyle(Color.backgrounYellow)
        })
    }
}
