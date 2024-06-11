//
//  ProfileViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 4/27/24.
//

import Foundation
import UIKit
import Moya
import Alamofire
import Combine

class ProfileViewModel: ObservableObject, ImageHandling {
    
    
    private let keyChainManger = KeyChainManager.standard
    
    var provider: MoyaProvider<ProfileAPITarget>
    @Published public var isProfileCompleted: Bool
    
    init(provider: MoyaProvider<ProfileAPITarget> = APIManager.shared.createProvider(for: ProfileAPITarget.self),
         isProfileCompleted: Bool) {
        self.provider = provider
        self.isProfileCompleted = isProfileCompleted
    }
    
    // MARK: - NicknameProperty
    /// 입력한 닉네임 길이
    @Published public var nickNameText: String = "" {
        didSet {
            if nickNameText.count >= 2 {
                beginBtn = true
            } else {
                beginBtn = false
            }
        }
    }
    
    // MARK: - btnProperty
    /// 시작하기 버튼 활성화 여부 판단
    @Published public var beginBtn: Bool = false
    
    // MARK: - ImageProperty
    /// 이미지 피커 선택되었는가?
    @Published var isImagePickerPresendted: Bool = false
    
    
    @Published private var profileImageData: Data?
    var selectedImage: UIImage?
    
    
    // MARK: - ProfileImaegHandle
    
    /// 선택한 이미지 추가
    /// - Parameter images: 선택한 이미지 UIImage 타입으로 저장
    public func addImage(_ images: UIImage?) {
        if let image = images {
            selectedImage = image
        }
    }
    
    /// 이미지 피커 불러오기
    public func showImagePicker() {
        isImagePickerPresendted.toggle()
    }
    
    // MARK: - ProfileModel NickName API
    
    
    
    
    
    /// 프로필 지정 값 서버로 전송
    public func sendUserNickName(appState: UserState) {
        provider.request(.sendUserNickName(userNameInfo: nickNameText)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleNameResponse(response: response, appState: appState)
            case .failure(let error):
                print("유저 닉네임 정보 네트워크 오류: \(error)")
            }
        }
    }
    
    /// API 응답 처리 및 이미지 다운로드
    /// - Parameter response: 호출 성공 시 받는 데이터
    private func handleNameResponse(response: Response, appState: UserState) {
        do {
            let decodedData = try JSONDecoder().decode(NickNameData.self, from: response.data)
            print("닉네임 정보 완료 : \(decodedData)")
            if decodedData.status == 200 {
                keyChainManger.updateNickname(self.nickNameText, for: "userSession")
                appState.updateName(userName: nickNameText)
            } else {
                print("닉네임 정보 업데이트 상태 코드 200 x")
            }
        } catch {
            print("유저 닉네임 정보 디코드 오류 : \(error)")
        }
    }
    
    // MARK: - ProfileModel ProfileImage API
    
    public func sendUserProfileImage(app: UserState) {
        guard let image = selectedImage else { return }
        provider.request(.sendUserImage(image: image)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleProfileImageResponse(response: response, appState: app)
            case .failure(let error):
                print("유저 프로필 정보 네트워크 오류 : \(error)")
            }
        }
    }
    
    private func handleProfileImageResponse(response: Response, appState: UserState) {
        do {
            let decodedData = try JSONDecoder().decode(ProfileImageData.self, from: response.data)
            if decodedData.status == 200 {
                keyChainManger.updateUserProfile(decodedData.result.profileImageUrl, for: "userSession")
                appState.updateURL(userURL: URL(string: decodedData.result.profileImageUrl)!)
            }
        } catch {
            print("유저 프로필 정보 디코드 오류 : \(error)")
        }
    }
    
}
