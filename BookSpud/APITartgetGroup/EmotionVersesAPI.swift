//
//  EmotionVersesAPI.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya

enum EmotionVersesAPI {
    case bookMarkVerses(emotion: String)
}

extension EmotionVersesAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .bookMarkVerses(let emotion):
            return "/api/bookmark/random/\(emotion)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bookMarkVerses:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .bookMarkVerses:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
