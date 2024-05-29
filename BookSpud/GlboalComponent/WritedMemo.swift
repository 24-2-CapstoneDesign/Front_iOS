//
//  WritedMemo.swift
//  BookSpud
//
//  Created by 정의찬 on 5/29/24.
//

import SwiftUI

/// 북마크 상세 보기 뷰의 텍스트 메모 컴포넌트
struct WritedMemo: View {
    
    var text: String?
    
    init(text: String?) {
        self.text = text?.isEmpty ?? true ? "메모가 없습니다" : text
    }
    
    var body: some View {
        ZStack(alignment: .center, content: {
            background
            textMemo
        })
    }
    
    // MARK: - WritedMemoView
    private var background: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.white)
            .frame(maxWidth: 340, maxHeight: 132)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.primary1, lineWidth: 2)
            )
            .shadow03()
    }
    
    /// 메모 텍스트
    private var textMemo: some View {
        Text(text ?? "메모가 없습니다.")
            .font(.spoqaHans(type: .medium, size: 12))
            .foregroundStyle(Color.gray07)
            .kerning(-0.2)
            .frame(maxWidth: 300, maxHeight: 87)
    }
}

struct WritedMemo_Preview: PreviewProvider {
    static var previews: some View {
        WritedMemo(text: "")
            .previewLayout(.sizeThatFits)
    }
}


