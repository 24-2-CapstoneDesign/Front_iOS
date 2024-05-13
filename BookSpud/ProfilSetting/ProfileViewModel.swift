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

class ProfileViewModel: ObservableObject, ImageHandling {
    
    // MARK: - API Property
    private let keyChainManger = KeyChainManager.standard
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<ProfileAPITarget>
    
    init() {
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<ProfileAPITarget>(session: session)
    }
    
    // MARK: - UserAgeProperty
    /// 피커뷰로 선택하는 유저 나이 정보
    @Published var userAge: Int = 18
    
    // MARK: - NicknameProperty
    /// 입력한 닉네임 길이
    @Published public var nickNameText: String = "" {
        didSet {
            if nickNameText.count >= 3 {
                beginBtn = true
            } else {
                beginBtn = false
            }
        }
    }
    
    @Published public var isProfileCompleted: Bool = false
    
    // MARK: - btnProperty
    /// 시작하기 버튼 활성화 여부 판단
    @Published public var beginBtn: Bool = false
    
    // MARK: - ImageProperty
    /// 이미지 피커 선택되었는가?
    @Published var isImagePickerPresendted: Bool = false
    
    
    @Published private var profileImageData: Data?
    var selectedImage: UIImage?
    private var profileModel: ProfileModel?
    
    
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
    
    // MARK: - ProfileModel API Send
    
    /// 저장돤 데이터에 대해 ProfileModel에 저장하여 반환한다.
    /// - Returns: 유저 닉네임, 데이터 타입으로 저장된 이미지를 담은 모델 반환
    private func inputUserData() -> ProfileModel? {
        if let profileImageData = self.selectedImage {
            profileModel = ProfileModel(userNickname: self.nickNameText,
                                        profileImage: profileImageData.jpegData(compressionQuality: 0.5))
            
            return profileModel
        } else {
            return nil
        }
    }
    
    //TODO: - 사진 이미지 전송 API 작성 및 유저 데이터 전송
    //TODO: - 데이터 전송 성공 시, 사진 캐시 저장 닉네임 키체인 저장
    /// 프로필 지정 값 서버로 전송
    public func sendUserProfile() {
        guard let userInfo = inputUserData() else { return }
        provider.request(.sendUserData(userInfo: userInfo)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(UserInfo.self, from: response.data)
                    self?.keyChainManger.updateNickname(userInfo.userNickname, for: "userSession")
                    print("닉네임 업데이트 완료")
                } catch {
                    print("닉네임 업데이트 오류: \(error)")
                }
            case .failure(let error):
                print("유저 프로필 전송 오류 : \(error)")
            }
        }
    }
}
