//
//  CustomTabView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/11/24.
//

import SwiftUI

/// 커스텀 탭바를 만들기 위함 해당 뷰를 통해 Radius와 Shadow가 들어간 탭바를 사용할 수 있다
struct CustomTabView: View {
    
    @Binding var selectedTab: BookSpudTab
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                ForEach(BookSpudTab.allCases, id: \.rawValue) { tab in
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.spring()) {
                            selectedTab = tab
                        }
                    } label: {
                        Icon(rawValue: tab.rawValue)?
                            .icon(for: selectedTab == tab)
                            .fixedSize()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(selectedTab == tab ? Color.primary1 : Color.black)
                    }
                    
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: 80)
            .background(Color.white)
            .roundedCorner(20, corners: [.topLeft, .topRight])
            .shadow(color: .black.opacity(0.25), radius: 20, x: 0, y: -1)
            .ignoresSafeArea(.keyboard)
            .position(x: geo.size.width / 2, y: geo.size.height - 9)
        }
    }
}
