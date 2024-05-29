//
//  EmotionVersesView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/16/24.
//

import SwiftUI

/// 감정선택과 감정에 해당하는 최근 책의 구절 보이는 뷰
struct EmotionVersesView: View {
    
    @StateObject var viewModel: EmotionVersesViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 15, content: {
            SelectEmotionView(viewModel: viewModel)
            
            if viewModel.isEmotionPickerPresented {
                EmotionPickerView(viewModel: viewModel)
            }
            
            BookVersesView(viewModel: viewModel)
        })
        .frame(maxWidth: 380, minHeight: 210)
        .animation(.easeInOut, value: viewModel.isEmotionPickerPresented)
    }
}

#Preview {
    EmotionVersesView(viewModel: EmotionVersesViewModel())
        .previewLayout(.sizeThatFits)
}
