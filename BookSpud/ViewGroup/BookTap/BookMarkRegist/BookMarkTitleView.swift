//
//  BookMarkTitleView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import SwiftUI

struct BookMarkTitleView: View {

    var emotion: BookEmotionKind
    
    // MARK: - Init
    
    init(emotion: BookEmotionKind) {
        self.emotion = emotion
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            titleView
            emotionImage(emotion)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 60, maxHeight: 63)
        }
        .animation(.spring, value: emotion)
    }
    
    private var titleView: some View {
        Text(titleString(emotion))
            .font(.gangwonEdu(type: .basic, size: 16))
            .foregroundStyle(Color.black)
    }
        
    private func emotionImage(_ emotion: BookEmotionKind) -> Image {
        switch emotion {
        case .happy:
            return Icon.happySpud.image
        case .sad:
            return Icon.sadSpud.image
        case .angry:
            return Icon.angrySpud.image
        case .inspiration:
            return Icon.inspirationSpud.image
        case .move:
            return Icon.sensationSpud.image
        }
    }
    
    
    private func titleString(_ emotion: BookEmotionKind) -> String {
        switch emotion {
        case .happy:
            return "안녕 나는 의감자야"
        case .sad:
            return "안녕 나는 상감자야"
        case .angry:
            return  "안녕 나는 한감자야"
        case .inspiration:
            return "안녕 나는 초감자야"
        case .move:
            return "안녕 나는 수감자아"
        }
    }
}

struct BookMarkTitleView_Preview: PreviewProvider {
    static var previews: some View {
        BookMarkTitleView(emotion: .happy)
    }
}
