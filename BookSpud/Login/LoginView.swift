//
//  ContentView.swift
//  BookSpud
//
//  Created by 정의찬 on 4/12/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel: LoginViewModel
    
    var body: some View {
            allGroup
        }
    
    // MARK: - AllGroup
    
    private var allGroup: some View {
        VStack(alignment: .center, content: {
            Spacer().frame(maxHeight: 120)
            loginTopView
            Spacer().frame(maxHeight: 220)
            loginBottomView
        })
    }
    
    
    // MARK: - TopView
    
    private var loginTopView: some View {
        VStack(alignment: .center, spacing: 27) {
            Icon.logo.image
                .fixedSize()
                .frame(maxWidth: 185, maxHeight: 174)
                .aspectRatio(contentMode: .fit)
            
            loginTitleGroup
        }
    }
    
    /// 상단 탑 타이틀
    private var loginTitleGroup: some View {
        VStack(alignment: .center, spacing: 11) {
            Text("Book Spud")
                .font(.spoqaHans(type: .bold, size: 28))
                .kerning(-2)
                .foregroundStyle(Color.gray07)
                .frame(maxWidth: 150, maxHeight: 35)
            
            Text("독서, 무한한 지식의 여정을 시작하세요!")
                .font(.spoqaHans(type: .regular, size: 14))
                .kerning(-2)
                .foregroundStyle(.gray05)
                .frame(maxWidth: 240, maxHeight: 18)
        }
    }
    
    // MARK: - BottomView
    
    /// 하단 로그인 제목
    private var loginBottomView: some View {
        VStack(alignment: .center, spacing: 25, content: {
            
            Text("로그인")
                .font(.spoqaHans(type: .medium, size: 14))
                .kerning(-2)
                .foregroundStyle(Color.gray07)
            
            Divider()
                .background(Color.gray04)
                .frame(maxWidth: 237)
            
            loginBtnGroup
        })
        .padding([.top, .bottom], 10)
    }
    
    /// 로그인 버튼 그룹
    private var loginBtnGroup: some View {
        HStack(alignment: .center, spacing: 70, content: {
            
            Button(action: {
                loginViewModel.loginKakao()
            }, label: {
                Icon.kakao.image
                    .fixedSize()
                    .aspectRatio(contentMode: .fit)
            })
            
            Button(action: {
                print("apple로그인 버튼")
            } , label: {
                Icon.apple.image
                    .fixedSize()
                    .aspectRatio(contentMode: .fit)
            })
        })
    }
}

struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewModel: LoginViewModel())
            .previewLayout(.sizeThatFits)
            .previewDevice("iPhone 15 Pro Max")
            .previewDevice("iPhone 11")
    }
}
