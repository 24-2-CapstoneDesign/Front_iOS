//
//  ProfilSettingView.swift
//  BookSpud
//
//  Created by 정의찬 on 4/13/24.
//

import SwiftUI

struct ProfilSettingView: View {
    var body: some View {
        profilTitleView
    }
    
    // MARK: - TopView
    
    private var profilTitleView: some View {
        VStack(alignment: .center, spacing: 21, content: {
            
            Button(action: {
                print("이미지 버튼 클릭")
            }, label: {
                Icon.profil.image
                    .fixedSize()
                    .aspectRatio(contentMode: .fit)
            })
            
            Text("원하는 프로필을 넣어주세요!")
                .font(.spoqaHans(type: .bold, size: 19))
                .foregroundStyle(.subText)
                .frame(minWidth: 226)
        })
    }
}


struct ProfilSetting_Preview: PreviewProvider {
    static var previews: some View {
        ProfilSettingView()
            .previewLayout(.sizeThatFits)
    }
}
