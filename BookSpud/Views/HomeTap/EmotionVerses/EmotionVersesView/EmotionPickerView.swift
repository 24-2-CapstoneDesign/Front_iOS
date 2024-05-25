//
//  EmotionPickerView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/17/24.
//

import SwiftUI

struct EmotionPickerView: View {
    
    let emotionList: [EmotionPickerData] = EmotionDataList.emotionList
    @StateObject var emotionVersesViewModel: EmotionVersesViewModel
    
    var body: some View {
        emotionPickerView
            .opacity(emotionVersesViewModel.isEmotionPickerViewAnimation ? 1 : 0)
            .onAppear {
                withAnimation(.easeIn(duration: 0.5)) {
                    emotionVersesViewModel.isEmotionPickerViewAnimation = true
                }
            }
            .onDisappear {
                withAnimation(.bouncy(duration: 1.5)) {
                    emotionVersesViewModel.isEmotionPickerViewAnimation = false
                }
            }
    }
    
    private var emotionPickerView: some View {
        HStack(alignment: .center, content: {
            
            Spacer()
            
            ForEach(emotionList, id: \.name) { emotion in
                Button(action: {
                    emotionVersesViewModel.changeEmotionImage(emotion.emotionImage)
                    emotionVersesViewModel.easeOutAnimationEffect()
                }, label: {
                    emotion.emotionImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 36, maxHeight: 20)
                })
                .background(Color.white)
                .frame(maxWidth: 45)
                .padding([.vertical, .horizontal], 5)
            }
            
            Spacer()
        })
        .frame(maxWidth: 350, maxHeight: 40)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.primary1, lineWidth: 0.5)
        )
    }
}
