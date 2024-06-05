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
    var onOff: Bool
    var height: CGFloat
    var padding: CGFloat
    var rightPlus: Image?
    var action: () -> Void?
    @Environment(\.dismiss) var dimiss
    
    /// 커스텀 네비게이션
    /// - Parameters:
    ///   - title: 네바게이션 타이틀
    ///   - chevron: 네비게이션 버튼 이미지
    ///   - onOff: 배경 온 오프
    ///   - height: 높이 지정
    ///   - padding: 패딩 값
    init(
        title: String,
        chevron: Image = Image(systemName: "chevron.left"),
        onOff: Bool = true,
        height: CGFloat = 120,
        padding: CGFloat = 20,
        rightPlus: Image? = nil,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.chevron = chevron
        self.onOff = onOff
        self.height = height
        self.padding = padding
        self.rightPlus = rightPlus
        self.action = action
    }
    
    
    var body: some View {
        navigationView
    }
    
    // MARK: - Property
    
    /// 전체 네비게이션 뷰
    private var navigationView: some View {
        ZStack(alignment: .bottom, content: {
            if onOff {
                TopRadiusView(radius: 0, height: 120)
            }
            navigationViewComponents
        })
        .frame(maxWidth: 430, maxHeight: height)
    }
    
    /// 네비게이션 아이템 그룹
    private var navigationViewComponents: some View {
        HStack(alignment: .center, content: {
            
            if rightPlus == nil {
                Button(action: {
                    self.dimiss()
                }, label: {
                    chevron
                        .resizable()
                        .frame(maxWidth: 10, maxHeight: 18)
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(Color.black)
                })
            }
            
            Spacer()
            
            Text(title)
                .font(.pretendard(type: .regular, size: 16))
                .kerning(-0.5)
                .foregroundStyle(Color.black)
                .frame(minWidth: 44)
            
            Spacer()
            
            if let rightPlus = rightPlus {
                Button(action: {
                    action()
                }, label: {
                    rightPlus
                        .resizable()
                        .frame(maxWidth: 18, maxHeight: 18)
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(Color.black)
                })
            }
        })
        .frame(maxWidth: 360)
        .padding(.bottom, padding)
    }
}


struct CustomNavigation_Preview: PreviewProvider {
    static var previews: some View {
        CustomNavigation(title: "독후감", rightPlus: Image(systemName: "plus"))
    }
}
