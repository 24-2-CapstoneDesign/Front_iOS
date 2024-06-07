//
//  ProfileAPITarget.swift
//  BookSpud
//
//  Created by 정의찬 on 5/12/24.
//

import Moya
import Foundation
import SwiftUI

/// 유저 닉네임 및 초기 프로필 사진 지정 API 타겟
enum ProfileAPITarget {
    case sendUserNickName(userNameInfo: String) // 유저 닉네임 전달 API
    case sendUserImage(image: UIImage) // 유저 사진 전달 API
}

extension ProfileAPITarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .sendUserNickName:
            return "/api/user/nickname"
        case .sendUserImage:
            return "/api/user/profile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendUserNickName:
            return .post
        case .sendUserImage:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendUserNickName(let userName):
            return .requestParameters(parameters: ["nickname" : userName], encoding: JSONEncoding.default)
        case .sendUserImage(let imageData):
            var multipartData = [MultipartFormData]()
            
            if let imageData = imageData.jpegData(compressionQuality: 0.5) {
                let imageFormData = MultipartFormData(provider: .data(imageData), name: "image", fileName: "image", mimeType: "image/jpeg")
                multipartData.append(imageFormData)
            }
            
            return .uploadMultipart(multipartData)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .sendUserNickName:
            return [
                "Content-Type": "application/json",
                "accept": "*/*"
            ]
        case .sendUserImage:
            return [
                "Content-Type": "multipart/form-data",
                "accept": "*/*"
            ]
        }
    }
}
