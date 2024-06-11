//
//  ReadWriteText.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import SwiftUI

struct ReadWriteText: View {
    
    let title: String
    let verses: String
    let place: String
    let icon: Image
    @Binding var emotionMemo: String
    
    init(title: String, verses: String, place: String, icon: Image, emotionMemo: Binding<String>) {
        self.title = title
        self.verses = verses
        self.place = place
        self.icon = icon
        self._emotionMemo = emotionMemo
    }
    
    var body: some View {
        allView
    }
    
    private var allView: some View {
        VStack(alignment: .leading, spacing: 14, content: {
            
            topTitle
            
            loadVerses
            
            inputEmotionMemo
            
        })
        .frame(maxWidth: 373, maxHeight: 367)
        
    }
    
    /// 상단 제목
    private var topTitle: some View {
        Text("\(title) 📝")
            .font(.spoqaHans(type: .bold, size: 21))
            .foregroundStyle(Color.black)
    }
    
    /// 서론 본론 결론에 해당하는 구절
    private var loadVerses: some View {
        ZStack(alignment: .center, content: {
            
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white)
                .frame(maxWidth: 373, maxHeight: 150)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .inset(by: 2)
                        .stroke(Color.primary1, lineWidth: 2)
                        
                )
                .shadow03()
            
            Text(verses)
                .font(.spoqaHans(type: .regular, size: 12))
                .foregroundStyle(Color.gray07)
                .frame(width: 300, height: 87)
        })
    }
    
    private var inputEmotionMemo: some View {
        ZStack(alignment: .center, content: {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white)
                .shadow03()
                .frame(maxWidth: 367, maxHeight: 145)
            
            HStack(alignment: .center, content: {
                icon
                    .resizable()
                    .frame(maxWidth: 60, maxHeight: 63)
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                TextField(place, text: $emotionMemo, axis: .vertical)
                    .frame(maxWidth: 242, maxHeight: 113)
                    .font(.spoqaHans(type: .medium, size: 12))
                    .multilineTextAlignment(.center)
                    .background(Color.clear)
            })
            .frame(maxWidth: 327, maxHeight: 113)
        })
    }
}

struct Readadsad_Preview: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        ReadWriteText(title: "서론", verses: "아아 졸리다", place: "깜정을 기록햅좌", icon: Icon.sadSpud.image, emotionMemo: $text)
    }
}
