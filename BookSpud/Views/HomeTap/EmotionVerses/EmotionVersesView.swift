//
//  EmotionVersesView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/16/24.
//

import SwiftUI

/// 감정선택과 감정에 해당하는 최근 책의 구절 보이는 뷰
struct EmotionVersesView: View {
    
    @StateObject var emotionVersesViewModel =  EmotionVersesViewModel()
    
    var body: some View {
        VStack(alignment: .center, content: {
            SelectEmotionView(emotionVersesViewModel: emotionVersesViewModel)
        })
        .frame(maxWidth: 380, maxHeight: 210)
    }
}

#Preview {
    EmotionVersesView(emotionVersesViewModel: EmotionVersesViewModel())
}
