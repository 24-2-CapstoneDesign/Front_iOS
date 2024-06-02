//
//  KakaoBookAPITarget.swift
//  BookSpud
//
//  Created by 정의찬 on 6/2/24.
//

import Foundation
import Moya

enum KakaoBookAPITarget {
    case sedISBN(isbnCode: String)
}

extension KakaoBookAPITarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://dapi.kakao.com")!
    }
    
    var path: String {
        switch self {
        case .sedISBN:
            return "/v3/search/book"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sedISBN:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .sedISBN(let isbnCode):
            return .requestParameters(
                parameters: ["query": isbnCode, "target": "isbn"],
                encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "KakaoAK d2ac0581e517eabd58544a515abc544b"
        ]
    }
}
