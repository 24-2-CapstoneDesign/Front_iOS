//
//  CustomNavigation.swift
//  BookSpud
//
//  Created by 정의찬 on 5/23/24.
//

import SwiftUI

/// 네비게이션 뷰에서 이전 화면으로 돌아가기 위한 커스텀 네비게이션
struct CustomNavigation: View {
    
    // MARK: - Init
    
    var title: String
    var chevron: Image
    @Environment(\.dismiss) var dimiss
    
    init(
        title: String,
        chevron: Image = Image(systemName: "chevron.left")
    ) {
        self.title = title
        self.chevron = chevron
    }
    
    
    var body: some View {
        navigationView
    }
    
    // MARK: - Property
    
    /// 전체 네비게이션 뷰
    private var navigationView: some View {
        ZStack(alignment: .bottom, content: {
            TopRadiusView(radius: 0, height: 120)
            navigationViewComponents
        })
        .frame(width: 430, height: 120)
    }
    
    /// 네비게이션 아이템 그룹
    private var navigationViewComponents: some View {
        HStack(alignment: .center, content: {
            
            Button(action: {
                self.dimiss()
            }, label: {
                chevron
                    .resizable()
                    .frame(maxWidth: 10, maxHeight: 18)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.black)
            })
            
            
            Spacer()
            
            Text(title)
                .font(.pretendard(type: .bold, size: 16))
                .kerning(-0.2)
                .foregroundStyle(Color.black)
                .frame(minWidth: 44)
            
            Spacer()
        })
        .frame(maxWidth: 320)
        .padding(.bottom, 21)
    }
}


struct CustomNavigation_Preview: PreviewProvider {
    static var previews: some View {
        CustomNavigation(title: "책 정보")
    }
}
