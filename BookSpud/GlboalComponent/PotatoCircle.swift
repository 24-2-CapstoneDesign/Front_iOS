//
//  PotatoCircle.swift
//  BookSpud
//
//  Created by 정의찬 on 5/14/24.
//

import SwiftUI

struct PotatoCircle: View {
    
    var image: Image
    
    var body: some View {
        Circle()
            .fill(Color(red: 0.56, green: 0.56, blue: 0.56).opacity(0.3))
            .frame(maxWidth: 53, maxHeight: 53)
            .overlay(
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 53, maxHeight: 53)
                    .clipShape(Circle())
            )
    }
}

#Preview {
    PotatoCircle(image: Icon.cutyPotato.image)
        .previewLayout(.sizeThatFits)
}
