//
//  BookMarkReadAPITarget.swift
//  BookSpud
//
//  Created by 정의찬 on 6/11/24.
//

import Foundation
import Moya

enum BookMarkReadAPITarget {
    case bookMarkRead(id: Int)
}

extension BookMarkReadAPITarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .bookMarkRead(let id):
            return "/api/bookmark/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bookMarkRead:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .bookMarkRead:
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
