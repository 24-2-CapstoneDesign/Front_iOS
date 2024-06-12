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
    var place: String
    let icon: Image
    let changeOn: Bool
    @Binding var emotionMemo: String
    @FocusState private var isTextFocused: Bool
    
    init(title: String, verses: String, place: String, icon: Image, changeOn: Bool = true, emotionMemo: Binding<String>,
         isTextFocused: Bool = false
    ) {
        self.title = title
        self.verses = verses
        self.place = place
        self.icon = icon
        self.changeOn = changeOn
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
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 5)
                .frame(maxWidth: 367, maxHeight: 145)
            
            HStack(alignment: .center) {
                icon
                    .resizable()
                    .frame(maxWidth: 60, maxHeight: 63)
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                ZStack(alignment: .center) {
                   
                    
                    if changeOn {
                        TextField("", text: $emotionMemo)
                            .frame(maxWidth: 242, maxHeight: 113)
                            .font(.spoqaHans(type: .medium, size: 12))
                            .foregroundStyle(Color.black)
                            .multilineTextAlignment(.leading)
                            .background(Color.clear)
                            .focused($isTextFocused)
                        
                        if emotionMemo.isEmpty && !isTextFocused {
                            Text(place)
                                .foregroundColor(Color.gray05)
                                .padding(.top, 8)
                                .padding(.horizontal, 4)
                                .font(.spoqaHans(type: .light, size: 12))
                                .multilineTextAlignment(.center)
                                .onTapGesture {
                                    self.isTextFocused = true
                                }
                        }
                        
                    } else {
                        Text(emotionMemo.isEmpty ? place : emotionMemo)
                            .frame(maxWidth: 242, maxHeight: 113)
                            .font(.spoqaHans(type: .medium, size: 12))
                            .foregroundStyle(Color.black)
                            .multilineTextAlignment(.leading)
                            .background(Color.clear)
                    }
                }
            }
            .frame(maxWidth: 327, maxHeight: 113)
        }
    }
}
