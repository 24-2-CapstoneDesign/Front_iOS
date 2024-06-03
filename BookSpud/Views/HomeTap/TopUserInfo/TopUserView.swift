//
//  TopUserView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/14/24.
//

import SwiftUI

struct TopUserView: View {
    
    @StateObject var viewModel: TopUserViewModel
    
    var body: some View {
        topRoundView
            .onAppear {
                viewModel.getUserData()
            }
    }
    
    // MARK: - TopUserViewProperty
    
    private var topRoundView: some View {
        ZStack(alignment: .center) {
            TopRadiusView(radius: 50, height: 160)
            userData
        }
        .frame(height: 160)
    }
    
    /// 상단 유저 데이터
    private var userData: some View {
        HStack(alignment: .center, spacing: 10, content: {
            
            PotatoCircle(image: viewModel.userProfileImage)
            
            Text("Hello! \(viewModel.userNickname)")
                .frame(maxWidth: 250, alignment: .leading)
                .font(.spoqaHans(type: .bold, size: 24))
                .lineSpacing(-2)
                .foregroundStyle(Color.gray07)
            
            Spacer().frame(maxWidth: 10)
            
            Icon.optionBtn.image
                .fixedSize()
                .aspectRatio(contentMode: .fit)
            
        })
        .frame(maxWidth: 380)
        .padding(.horizontal, 5)
        .padding(.top, 25)
    }
}

struct TopUserView_Preview: PreviewProvider {
    
    static let devices = ["iPhone 11", "iPhone 15 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            TopUserView(viewModel: TopUserViewModel())
                .previewLayout(.sizeThatFits)
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
