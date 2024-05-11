//
//  ProfileAPITarget.swift
//  BookSpud
//
//  Created by 정의찬 on 5/12/24.
//

import Moya
import Foundation

enum ProfileAPITarget {
    case sendUserData(userInfo: ProfileModel)
}

extension ProfileAPITarget: TargetType {
    var baseURL: URL {
        return URL(string: "example")!
    }
    
    var path: String {
        switch self {
        case .sendUserData:
            return "userData"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendUserData:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendUserData(let data):
            return .requestParameters(parameters: ["userData" : data], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
