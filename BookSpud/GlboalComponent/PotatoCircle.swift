//
//  PotatoCircle.swift
//  BookSpud
//
//  Created by 정의찬 on 5/14/24.
//

import SwiftUI

struct PotatoCircle: View {
    
    var image: Image
    var maxWidth: CGFloat
    var maxHeight: CGFloat
    
    init(image: Image,
         maxWidth: CGFloat = 53,
         maxHeight: CGFloat = 53)
    {
        self.image = image
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
    }
    
    var body: some View {
        Circle()
            .fill(Color(red: 0.56, green: 0.56, blue: 0.56).opacity(0.3))
            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
            .overlay(
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                    .clipShape(Circle())
            )
    }
}

#Preview {
    PotatoCircle(image: Icon.cutyPotato.image)
        .previewLayout(.sizeThatFits)
}
