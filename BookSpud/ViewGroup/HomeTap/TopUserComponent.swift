//
//  TopUserView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/14/24.
//

import SwiftUI
import Kingfisher

struct TopUserComponent: View {
    @EnvironmentObject var userState: UserState
    var body: some View {
        topRoundView   
    }
    
    // MARK: - TopUserViewProperty
    
    private var topRoundView: some View {
        ZStack(alignment: .center) {
            TopRadiusView(radius: 50, height: 160)
            userData
        }
        .frame(height: 160)
    }
    
    @ViewBuilder
    ///프로필 사진
    private var profileImage: some View {
        if let url = userState.userProfile {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .frame(width: 53, height: 53)
                }
                
                .resizable()
                .frame(minWidth: 50, maxWidth: 53, maxHeight: 53)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
        } else {
            PotatoCircle(image: Icon.cutyPotato.image)
        }
    }
    
    /// 상단 유저 데이터
    private var userData: some View {
        HStack(alignment: .center, spacing: 10, content: {
            
            profileImage
            
            Text("Hello! \(userState.userName ?? "")")
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
