//
//  BookMarkRegistViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya

enum BookMarkRegistAPI {
    case sendBookMarkRegist(id: Int, data: BookMarkRegistData)
}

extension BookMarkRegistAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .sendBookMarkRegist:
            return "/api/bookmark"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendBookMarkRegist:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendBookMarkRegist(let id, let dataBookMark):
            return .requestParameters(parameters: [
                "myBookId": id,
                "phase": dataBookMark.phase,
                "page": dataBookMark.page,
                "memo": dataBookMark.memo,
                "emotion": dataBookMark.emotion
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
