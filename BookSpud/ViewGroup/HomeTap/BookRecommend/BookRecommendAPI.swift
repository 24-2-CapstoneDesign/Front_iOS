//
//  BookRecommendAPI.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya

enum BookToBook {
    case bookTobook
    case detailBookInfo(id: Int)
}


extension BookToBook: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .bookTobook:
            return "/api/recent/book"
        case .detailBookInfo(let id):
            return "/api/book/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bookTobook:
            return .get
        case .detailBookInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
            case .bookTobook:
                return .requestPlain
        case .detailBookInfo:
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
