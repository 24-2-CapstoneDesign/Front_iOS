//
//  BookListAPI.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya

enum BookListAPI {
    case bookListAPI
}

extension BookListAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .bookListAPI:
            return "/api/book"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bookListAPI:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .bookListAPI:
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
