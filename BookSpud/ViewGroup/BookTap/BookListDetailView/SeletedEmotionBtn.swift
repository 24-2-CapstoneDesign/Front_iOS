//
//  seletedEmotionBtn.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import SwiftUI

/// 감정 북마크 조회 버튼
struct SeletedEmotionBtn: View {
    
    var title: String
    var currentStatus: BookEmotionKind
    @Binding var selected: BookEmotionKind
    var action: () -> Void
    
    init(title: String, currentStatus: BookEmotionKind, selected: Binding<BookEmotionKind>, action: @escaping () -> Void) {
        self.title = title
        self.currentStatus = currentStatus
        self._selected = selected
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            VStack(alignment: .center, spacing: -5, content: {
                Text(title)
                    .font(selected == currentStatus ? .spoqaHans(type: .bold, size: 20) : .spoqaHans(type: .regular, size: 20))
                    .kerning(-0.2)
                    .foregroundStyle(selected == currentStatus ? Color.gray07 : Color.gray06)
                if selected == currentStatus {
                    Rectangle()
                        .fill(returnColor(selected))
                        .frame(width: 40, height: 4)
                        .transition(.opacity)
                        .padding(.top, 5)
                }
            })
        })
        .animation(.easeInOut, value: selected)
    }
    
    private func returnColor(_ current: BookEmotionKind) -> Color {
        switch current {
        case .happy:
            return Color.touchedYellow
        case .sad:
            return Color.sadBlue
        case .angry:
            return Color.angryRed
        case .inspiration:
            return Color.inspiredGreen
        case .move:
            return Color.touchedPurple
        }
    }
}
