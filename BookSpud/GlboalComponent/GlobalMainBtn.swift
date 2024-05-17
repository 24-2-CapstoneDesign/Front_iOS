//
//  GlboalYellowBtn.swift
//  BookSpud
//
//  Created by 정의찬 on 4/27/24.
//

import SwiftUI

struct GlobalMainBtn: View {
    
    // MARK: - Property
    
    @Binding var clickBool: Bool
    
    let btnName: String
    let btnImg: Icon?
    let onClicked: () -> Void
    
    // MARK: - Init
    
    init(clickBool: Binding<Bool>,
         btnName: String,
         btnImg: Icon?,
         onClicked: @escaping () -> Void) {
        self._clickBool = clickBool
        self.btnName = btnName
        self.btnImg = btnImg
        self.onClicked = onClicked
    }
    
    var body: some View {
        Button(action: {
            if clickBool {
                onClicked()
            }
        }, label: {
            btnTextImage
        })
        .disabled(!clickBool)
    }
    
    /// 버튼 내부 이미지 및 텍스트
    private var btnTextImage: some View {
        HStack(alignment: .center, spacing: 10, content: {
            
            if let btnImg = btnImg {
                btnImg.image
                    .fixedSize()
                    .aspectRatio(contentMode: .fit)
            }
            
            Text(btnName)
                .font(.spoqaHans(type: .medium, size: 16))
                .foregroundStyle(Color.gray07)
                .multilineTextAlignment(.center)
        })
        .frame(minWidth: 300, minHeight: 50)
        .background(btnColor())
        .clipShape(.rect(cornerRadius: 12))
    }
    
    // MARK: - BtnText
    
    /// 버튼 색상 지정 후 리턴
    /// - Returns: true : primary1, false : subBtn
    private func btnColor() -> Color {
        if clickBool {
            return Color.primary1
        } else {
            return Color.subBtn
        }
    }
}

struct GlboalMainBtn_Preview: PreviewProvider {
    
    static var previews: some View {
        
        @State var clickedBool: Bool = false
        
        GlobalMainBtn(clickBool: $clickedBool,
                      btnName: "시작하기",
                      btnImg: Icon.inputISBN,
                      onClicked: {
            print("hello")
        })
        .previewLayout(.sizeThatFits)
    }
}
