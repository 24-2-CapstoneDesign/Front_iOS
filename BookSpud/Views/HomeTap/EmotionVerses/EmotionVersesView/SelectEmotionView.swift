//
//  SelsectEmotion.swift
//  BookSpud
//
//  Created by 정의찬 on 5/16/24.
//

import SwiftUI

/// 감정 선택 뷰
struct SelectEmotionView: View {
    
    // MARK: - Propery
    @StateObject var viewModel: EmotionVersesViewModel
    
    // MARK: - View
    var body: some View {
            HStack(alignment: .center, spacing: 14, content: {
                guideTextLeft
                guideImage
                guideTextRight
            })
            .frame(maxWidth: 360, maxHeight: 34)
    }
    
    // MARK: - View Property
    
    /// Left 가이드 텍스트
    private var guideTextLeft: some View {
        Text("오늘의 감정은")
            .frame(minWidth: 115, maxHeight: 25)
            .font(.spoqaHans(type: .bold, size: 20))
            .foregroundStyle(Color.gray06)
            .padding(.top, 8)
    }
    
    
    /// Right 가이드 텍스트
    private var guideTextRight: some View {
        Text("입니다.")
            .frame(maxWidth: 61, maxHeight: 25)
            .font(.spoqaHans(type: .bold, size: 20))
            .foregroundStyle(Color.gray06)
            .padding(.top, 8)
    }
    
    /// 감정 선택 이미지 창
    private var guideImage: some View {
        ZStack(alignment: .top, content: {
            
            Button(action: {
                viewModel.chagePickerPresented()
            }, label: {
                Icon.emotionBackground.image
                    .resizable()
                    .frame(minWidth: 147, maxHeight: 29)
                    .aspectRatio(contentMode: .fit)
            })
            .padding(.top, 8)
            
            HStack(alignment: .center, spacing: 6, content: {
                
                viewModel.spudFace
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 25.69, maxHeight: 27.38)
                
                viewModel.selectedEmotionImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 57, maxHeight: 32)
            })
        })
    }
}

struct SelectEmotion_Previews: PreviewProvider {
    static let devices = ["iPhone 11", "iPhone 15 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            SelectEmotionView(viewModel: EmotionVersesViewModel())
                .previewLayout(.sizeThatFits)
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
