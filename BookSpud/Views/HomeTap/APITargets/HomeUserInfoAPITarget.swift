//
//  ProfileAPITarget.swift
//  BookSpud
//
//  Created by 정의찬 on 5/14/24.
//

import Foundation
import Moya

enum HomeUserInfoAPITarget {
    case getProfileInfo
}

extension HomeUserInfoAPITarget : TargetType {
    var baseURL: URL {
        return URL(string: "example")!
    }
    
    var path: String {
        switch self {
        case .getProfileInfo:
            return "exampl2"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProfileInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getProfileInfo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
