//
//  CustomTextField.swift
//  BookSpud
//
//  Created by 정의찬 on 4/13/24.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    @FocusState private var isTextFocused: Bool
    
    let placeholder: String
    let cornerSize: CGFloat
    let showCheckIcon: Bool
    let onChecking: () -> Void
    let maxWidth: CGFloat
    let maxHeight: CGFloat
    let fontColor: Color
    
    
    init(
        text: Binding<String>,
         isTextFocused: Bool = false,
         placeholder: String,
         cornerSize: CGFloat = 100,
         showCheckIcon: Bool = false,
         onChecking: @escaping () -> Void,
         maxWidth: CGFloat,
         maxHeight: CGFloat,
         fontColor: Color
    ) {
        self._text = text
        self.placeholder = placeholder
        self.cornerSize = cornerSize
        self.showCheckIcon = showCheckIcon
        self.onChecking = onChecking
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.fontColor = fontColor
    }
    
    // TODO: - 텍스트필드 뷰 생성하기
    // MARK: - Body
    var body: some View {
        Text("텍스트 필드")
    }
}
