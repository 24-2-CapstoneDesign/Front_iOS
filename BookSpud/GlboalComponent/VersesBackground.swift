//
//  VersesBackground.swift
//  BookSpud
//
//  Created by 정의찬 on 5/29/24.
//

import SwiftUI

/// OCR을 통해 입력한 구절을 화면에 보인다.
/// OCR을 사용하는 뷰로 연결되도록 연결 작업이 구현되어 있다.
struct VersesBackground: View {
    
    // MARK: - Proverty
    
    var versesText: String?
    
    init(versesText: String?) {
        self.versesText = versesText?.isEmpty ?? true ? "입력된 구절이 없습니다." : versesText
    }
    
    var body: some View {
        ZStack(alignment: .center, content: {
            background
            
            Text(versesText ?? "입력된 구절이 없습니다.")
                .font(.gangwonEdu(type: .basic, size: 20))
                .kerning(-0.2)
                .foregroundStyle(Color.gray07)
                .frame(maxWidth: 300, maxHeight: 87)
            
            quotation
        })
    }
    
    // MARK: - VersesView Background
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.white)
            .frame(maxWidth: 340, maxHeight: 139)
            .shadow03()
    }
    
    private var quotation: some View {
        VStack(alignment: .leading, content: {
            Icon.leftQuota.image
                .fixedSize()
            
            Spacer()
            
            HStack(alignment: .center, content: {
                Spacer()
                
                Icon.rightQuota.image
                    .fixedSize()
            })
        })
        .frame(maxWidth: 324, maxHeight: 124)
    }
}

struct VersesBackground_View: PreviewProvider {
    static var previews: some View {
        VersesBackground(versesText: "하하")
    }
}
