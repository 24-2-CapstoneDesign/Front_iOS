//
//  MemoTextField.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import SwiftUI

struct MemoTextField: View {
    
    @Binding var text: String
    @FocusState private var isTextFocused: Bool
    
    let placeholder: String
    let cornerSize: CGFloat
    let maxWidth: CGFloat
    let maxHeight: CGFloat
    let maxCharacter: Int
    
    init(
        text: Binding<String>,
        isTextFocused: Bool = false,
        placeholder: String,
        cornerSize: CGFloat = 4,
        maxWidth: CGFloat,
        maxHeight: CGFloat,
        maxCharacter: Int = 200
    ) {
        self._text = text
        self.placeholder = placeholder
        self.cornerSize = cornerSize
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.maxCharacter = maxCharacter
    }
    
    var body: some View {
        ZStack(alignment: .center, content: {
            customTextField
            
            if text.isEmpty && !isTextFocused {
                placeholderInField
            }
        })
        .onTapGesture {
            isTextFocused = false
        }
    }
    
    private var placeholderInField: some View {
        Text(placeholder)
            .font(.spoqaHans(type: .regular, size: 12))
            .frame(maxWidth: maxWidth, minHeight: maxHeight - 10, maxHeight: maxHeight)
            .foregroundStyle(Color.gray06)
            .padding([.vertical, .horizontal], 5)
            .onTapGesture {
                isTextFocused = true
            }
    }
    
    private var customTextField: some View {
        TextField("", text: $text, axis: .vertical)
            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
            .font(.spoqaHans(type: .regular, size: 12))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.gray07)
            .padding([.top, .bottom], 10)
            .padding([.leading, .trailing], 10)
            .focused($isTextFocused)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: cornerSize))
            .overlay(
                RoundedRectangle(cornerRadius: cornerSize)
                    .inset(by: 0.5)
                    .stroke(Color.primary1, lineWidth: 2)
            )
            .shadow03()
            .onChange(of: text) { newValue, oldValue in
                if newValue.count > maxCharacter {
                    text = String(newValue.prefix(maxCharacter))
                }
            }
    }
}
