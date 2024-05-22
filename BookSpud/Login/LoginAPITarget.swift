//
//  LoginAPITarget.swift
//  BookSpud
//
//  Created by 정의찬 on 5/14/24.
//

import Foundation
import Moya

enum LoginAPITarget {
    case loginStart(token: String)
}

extension LoginAPITarget: TargetType {
    
    var baseURL: URL {
        return URL(string: "example")!
    }
    
    var path: String {
        switch self {
        case .loginStart:
            return "exaple"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loginStart:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .loginStart(let token):
            return .requestParameters(parameters: ["accessToken": token], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        switch self {
        case .loginStart:
            return Data("""
                {
                    "accessToken": "access-token-sample",
                    "refreshToken": "refresh-token-sample",
                }
                """.utf8)
        }
    }
}
