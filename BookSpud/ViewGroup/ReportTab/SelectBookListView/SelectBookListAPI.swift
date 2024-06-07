//
//  SelectBookListAPI.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya

enum SelectBookListAPI {
    case getBookList
}

extension SelectBookListAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .getBookList:
            return "/api/book"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBookList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getBookList:
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
