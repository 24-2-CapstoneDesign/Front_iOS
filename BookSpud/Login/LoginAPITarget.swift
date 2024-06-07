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
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .loginStart:
            return "/api/login/kakao"
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
                return .requestParameters(parameters: ["authorizationCode": token], encoding: URLEncoding.queryString)
            }
        }
    
    
    var headers: [String: String]? {
        
           return ["accept": "*/*"]
       }
}
