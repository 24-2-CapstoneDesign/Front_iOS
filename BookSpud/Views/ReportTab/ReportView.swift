//
//  ReportView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/11/24.
//

import SwiftUI

struct ReportView: View {
    var body: some View {
        allGroup
    }
    
    // MARK: - ReportView Group
    private var allGroup: some View {
        VStack(alignment: .center, spacing: 46, content: {
            
            CustomNavigation(title: "독후감", rightPlus: Image(systemName: "plus"), action: {
                print("액션 버튼 클릭")
            })
            
            Spacer()
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

#Preview {
    ReportView()
}
