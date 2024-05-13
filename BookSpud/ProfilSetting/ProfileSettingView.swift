//
//  ProfilSettingView.swift
//  BookSpud
//
//  Created by 정의찬 on 4/13/24.
//

import SwiftUI

struct ProfileSettingView: View {
    
    // MARK: - Property
    @StateObject var profileVM: ProfileViewModel
    
    var body: some View {
        allGroup
            .ignoresSafeArea(.keyboard)
            .onAppear(perform: {
                UIApplication.shared.hideKeyboard()
            })
    }
    
    // MARK: - AllGroup
    
    /// 닉네임 설정 뷰에 대한 모든 프로퍼티 그룹
    private var allGroup: some View {
        VStack(alignment: .center, content: {
            
            Spacer().frame(maxHeight: 120)
            
            profileSettingGroup
            
            Spacer().frame(maxHeight: 310)
            
            GlobalMainBtn(clickBool: $profileVM.beginBtn,
                          btnName: "시작하기",
                          btnImg: nil,
                          onClicked: {
                profileVM.sendUserProfile()
                profileVM.isProfileCompleted = true
            })
        })
        .sheet(isPresented: $profileVM.isImagePickerPresendted, content: {
            ShowImagePicker(imageHandler: profileVM)
        })
    }
    
    // MARK: - TopView
    
    private var profileSettingGroup: some View {
        VStack(alignment: .center, content: {
            profilTitleView
            
            Spacer()
            
            nickNameTextField
        })
        .frame(maxWidth: 297, maxHeight: 260)
    }
    
    /// 프로필 사진 지정 버튼
    private var profilTitleView: some View {
        VStack(alignment: .center, spacing: 21, content: {
            
            Button(action: {
                profileVM.showImagePicker()
            }, label: {
                if let selectedImage = profileVM.selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 127, maxHeight: 127)
                        .clipShape(Circle())
                } else {
                    Icon.profil.image
                        .fixedSize()
                        .aspectRatio(contentMode: .fit)
                }
            })
            
            Text("원하는 프로필을 넣어주세요!")
                .font(.spoqaHans(type: .bold, size: 19))
                .foregroundStyle(.subText)
                .frame(minWidth: 226)
        })
    }
    
    /// 닉네임 입력 필드
    private var nickNameTextField: some View {
        CustomTextField(text: $profileVM.nickNameText,
                        placeholder: "사용하고 싶은 닉네임을 작성해주세요!",
                        showCheckIcon: true,
                        maxWidth: 297,
                        maxHeight: 47)
    }
}


struct ProfileSetting_Preview: PreviewProvider {
    static let devices = ["iPhone 11", "iPhone 15 Pro Max"]
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            ProfileSettingView(profileVM: ProfileViewModel())
                .previewLayout(.sizeThatFits)
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
