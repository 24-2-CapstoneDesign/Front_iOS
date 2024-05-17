//
//  CustomTextField.swift
//  BookSpud
//
//  Created by 정의찬 on 4/13/24.
//

import SwiftUI

struct CustomTextField: View {
    
    // MARK: - Property
    
    @Binding var text: String
    @FocusState private var isTextFocused: Bool
    
    let placeholder: String
    let cornerSize: CGFloat
    let showCheckIcon: Bool
    let maxWidth: CGFloat
    let maxHeight: CGFloat
    
    // MARK: - init
    
    init(
        text: Binding<String>,
        isTextFocused: Bool = false,
        placeholder: String,
        cornerSize: CGFloat = 100,
        showCheckIcon: Bool,
        maxWidth: CGFloat,
        maxHeight: CGFloat
    ) {
        self._text = text
        self.placeholder = placeholder
        self.cornerSize = cornerSize
        self.showCheckIcon = showCheckIcon
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
    }
    
    // MARK: - Body
    var body: some View {
        textFieldGroup
    }
    
    // MARK: - CustomTextField
    
    /// 전체 필드 그룹
    private var textFieldGroup: some View {
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
    
    /// 텍스트 필드 내 Placeholder 지정
    private var placeholderInField: some View {
        Text(placeholder)
            .font(.spoqaHans(type: .medium, size: 13))
            .frame(minWidth: 193, minHeight: 16)
            .foregroundStyle(Color.gray07)
            .padding([.vertical, .horizontal], 3)
            .onTapGesture {
                isTextFocused = true
            }
    }
    
    /// 커스텀 텍스트 필드 생성
    private var customTextField: some View {
        ZStack(alignment: .trailing, content: {
            
            TextField("", text: $text, axis: .horizontal)
                .frame(minWidth: maxWidth, minHeight: maxHeight)
                .font(.spoqaHans(type: .medium, size: 13))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.gray07)
                .focused($isTextFocused)
                .background(Color.clear)
                .clipShape(.rect(cornerRadius: cornerSize))
                .overlay(
                    RoundedRectangle(cornerRadius: cornerSize)
                        .inset(by: 0.5)
                        .stroke(Color.gray07, lineWidth: 1)
                )
            
            if showCheckIcon && !text.isEmpty {
                IconinField()
                    .fixedSize()
                    .aspectRatio(contentMode: .fit)
                    .alignmentGuide(.trailing, computeValue: {
                        d in d[.trailing] + 20
                    })
            }
        })
    }
    
    // MARK: - Function
    
    /// 특별한 상황에 대해 이미지를 다르게 반환한다.
    /// - Returns: 체크 표시 혹은 비표시 이미지
    private func IconinField() -> Image {
        /* 체크 표시 이미지 */
        if text.count >= 3 {
            return Icon.checkNickname.image
        } else {
            return Icon.notCheckNickname.image
        }
    }
}


// MARK: - Preview
struct CustomTextField_Preview: PreviewProvider {
    
    static let devices = ["iPhone 11", "iPhone 15 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { deviceName in
            @State var text: String = "홍"
            CustomTextField(text: $text, placeholder: "하고 싶은 이름을 지정하세요", showCheckIcon: true, maxWidth: 297, maxHeight: 47)
                .previewLayout(.sizeThatFits)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
