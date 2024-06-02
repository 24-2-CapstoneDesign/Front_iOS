//
//  BookSatusBtn.swift
//  BookSpud
//
//  Created by 정의찬 on 6/2/24.
//

import SwiftUI

struct BookStatusBtn: View {
    
    var text: String
    var action: () -> Void
    var currentStatus: ReadingStatus
    @Binding var selected: ReadingStatus
    
    init(text: String, action: @escaping () -> Void, currentStatus: ReadingStatus ,selected: Binding<ReadingStatus>) {
        self.text = text
        self.action = action
        self.currentStatus = currentStatus
        self._selected = selected
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            VStack(alignment: .center, spacing: 0, content: {
                Text(text)
                    .font(selected == currentStatus ? .spoqaHans(type: .bold, size: 20) : .spoqaHans(type: .regular, size: 20))
                    .kerning(-0.2)
                    .foregroundStyle(selected == currentStatus ? Color.gray07 : Color.gray06)
                if selected == currentStatus {
                    Rectangle()
                        .fill(Color.gray07)
                        .frame(width: 50, height: 2)
                        .transition(.opacity)
                }
            })
        })
    }
}
