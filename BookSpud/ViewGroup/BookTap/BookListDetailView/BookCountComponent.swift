//
//  BookCountView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import SwiftUI

struct BookCountComponent: View {
    
    var count: Int
    var title: String
    
    init(count: Int, title: String) {
        self.count = count
        self.title = title
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 12, content: {
            if title == "북마크 수" {
                Text("\(count)")
                    .font(.spoqaHans(type: .bold, size: 16))
                    .foregroundStyle(Color.primaryDark)
                    .kerning(-0.2)
            } else {
                Text("\(count)쪽")
                    .font(.spoqaHans(type: .bold, size: 16))
                    .foregroundStyle(Color.primaryDark)
                    .kerning(-0.2)
            }
            Text(title)
                .font(.spoqaHans(type: .regular, size: 12))
                .foregroundStyle(Color.gray04)
                .kerning(-0.2)
        })
    }
}