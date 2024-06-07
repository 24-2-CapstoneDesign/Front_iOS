//
//  EmotionUserAPI.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya

enum EmotionUserAPI {
    case emotionBookMark(id: Int)
}

extension EmotionUserAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .emotionBookMark(let id):
            return "/api/bookmark/\(id)/others"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .emotionBookMark:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .emotionBookMark:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "accept": "*/*"
        ]
    }
}

