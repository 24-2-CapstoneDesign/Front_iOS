//
//  TopUserView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/14/24.
//

import SwiftUI

struct TopUserView: View {
    var body: some View {
        topRoundView
    }
    
    // MARK: - TopUserViewProperty
    
    private var topRoundView: some View {
        ZStack(alignment: .top) {
            TopRadiusView(radius: 50, height: 160)
            userData
        }
    }
    
    /// 상단 유저 데이터
    private var userData: some View {
        HStack(alignment: .center, spacing: 10, content: {
            
            PotatoCircle(image: Icon.cutyPotato.image)
            
            Text("Hello!, 감자님")
                .frame(maxWidth: 267, alignment: .leading)
                .font(.spoqaHans(type: .bold, size: 24))
                .lineSpacing(-2)
                .foregroundStyle(Color.gray07)
            
            Spacer().frame(maxWidth: 20)
            
            Icon.optionBtn.image
                .fixedSize()
                .aspectRatio(contentMode: .fit)
            
        })
        .frame(maxWidth: 400)
        .padding(.all, 5)
    }
}

struct TopUserView_Preview: PreviewProvider {
    
    static let devices = ["iPhone 11", "iPhone 15 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            TopUserView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
