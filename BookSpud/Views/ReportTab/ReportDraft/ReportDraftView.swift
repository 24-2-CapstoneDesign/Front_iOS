//
//  ReportDraftView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/5/24.
//

import SwiftUI

struct ReportDraftView: View {
    
    @StateObject var viewModel = ReportDraftViewModel()
    var body: some View {
        VStack(alignment: .center, spacing: 35, content: {
            CustomNavigation(title: "독후감 초안 생성")
            
            CurrentPage(viewModel: viewModel)
            
            Spacer()
        })
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(Color.backgrounYellow)
        .onTapGesture {
            UIApplication.shared.hideKeyboard()
        }
    }
}

#Preview {
    ReportDraftView()
}
