//
//  BookRecommendDetailRow.swift
//  BookSpud
//
//  Created by 정의찬 on 5/25/24.
//

import SwiftUI

struct BookRecommendDetailRow: View {
    
    var title: String
    var value: String
    var width: CGFloat
    var height: CGFloat
    var alignment: Alignment
    var onOff: Bool
    
    init(title: String,
         value: String,
         width: CGFloat = 167,
         hegiht: CGFloat = 10,
         alignment: Alignment = .leading,
         onOff: Bool = false
    ) {
        self.title = title
        self.value = value
        self.width = width
        self.height = hegiht
        self.alignment = alignment
        self.onOff = onOff
    }
    
    var body: some View {
        HStack(alignment: .center, content: {
            VStack(content: {
                Text(title)
                    .font(.spoqaHans(type: .bold, size: 12))
                    .kerning(-0.2)
                    .foregroundStyle(Color.primaryDark)
                
                if onOff {
                    Spacer()
                }
            })
            .frame(maxHeight: height)
            
            Text(value)
                .frame(maxWidth: width, maxHeight: height ,alignment: alignment)
                .font(.spoqaHans(type: .medium, size: 12))
                .kerning(-0.2)
                .foregroundStyle(Color.gray06)
                .multilineTextAlignment(.leading)
                .lineLimit(10)
                .truncationMode(.tail)
        })
        .frame(maxWidth: 209, maxHeight: height, alignment: .center)
    }
}