//
//  EmotionPickerView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/17/24.
//

import SwiftUI

struct EmotionPickerView: View {
    
    let emotionList: [EmotionData] = EmotionDataList.emotionList
    
    var body: some View {
        emotionPickerView
    }
    
    private var emotionPickerView: some View {
        HStack(alignment: .center, content: {
            
            Spacer()
            
            ForEach(emotionList, id: \.name) { emotion in
                Button(action: {
                    print(emotion)
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

struct EmotionPickerView_Preview: PreviewProvider {
    static let devices = ["iPhone 11", "iPhon 15 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id:\.self) { device in
            EmotionPickerView()
                .previewLayout(.sizeThatFits)
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
