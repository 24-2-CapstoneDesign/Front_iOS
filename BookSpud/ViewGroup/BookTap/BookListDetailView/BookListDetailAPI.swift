//
//  BookListDetailAPI.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya

enum BookListDetailAPI {
    case getBookMark(id: Int)
    case pageUpdagte(id: Int, total: Int, final: Int)
}

extension BookListDetailAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .getBookMark(let id):
            return "/api/bookmark/mybook/\(id)"
        case .pageUpdagte(let id, _, _):
            return "/api/book/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBookMark:
            return .get
        case .pageUpdagte:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .getBookMark:
            return .requestPlain
        case .pageUpdagte:
            return .requestParameters(parameters: [
                "totalPage": 0,
                "finalPage": 0
            ], encoding: JSONEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "accept": "*/*"
        ]
    }
}
