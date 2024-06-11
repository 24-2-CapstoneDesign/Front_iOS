//
//  ReportCardAPITarget.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya

enum ReportCardAPITarget {
    case sendEmotionData(id: Int, first: String, second: String, third: String)
}

extension ReportCardAPITarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .sendEmotionData(let id, _, _, _):
            return "/api/bookreport/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendEmotionData:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .sendEmotionData(_, let first, let second, let third):
            return .requestParameters(parameters: [
                "introEmotion": first,
                 "bodyEmotion": second,
                 "conclusionEmotion": third
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "accept": "*/*"
        ]
    }
}
