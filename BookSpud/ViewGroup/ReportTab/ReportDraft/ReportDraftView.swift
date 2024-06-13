//
//  ReportDraftView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/5/24.
//

import SwiftUI

/// 독후감 초안 생성 뷰
struct ReportDraftView: View {
    
    @StateObject var viewModel: ReportDraftViewModel
    
    init(bookData: BookListDetailData) {
        self._viewModel = StateObject(wrappedValue: ReportDraftViewModel(bookData: bookData))
    }
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 35, content: {
            CustomNavigation(title: "독후감 초안 생성", height: 70)
            
            CurrentPage(viewModel: viewModel)
            
            Spacer()
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(Color.backgrounYellow)
        .onAppear(perform: {
            UIApplication.shared.hideKeyboard()
        })
    }
}
