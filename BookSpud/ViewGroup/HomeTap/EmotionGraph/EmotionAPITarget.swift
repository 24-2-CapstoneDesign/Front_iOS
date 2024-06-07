//
//  EmotionAPITarget.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya

enum EmotionAPITarget {
    case getChart
}

extension EmotionAPITarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .getChart:
            return "/api/bookmark/count"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getChart:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getChart:
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
