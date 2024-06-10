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
    case pageUpdagte(id: Int, bookData: BookListDetailData)
}

extension BookListDetailAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .getBookMark(let id):
            return "/api/bookmark/mybook/\(id)"
        case .pageUpdagte(let id, _):
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
        case .pageUpdagte(_, let bookData):
            return .requestParameters(parameters: [
                "totalPage": bookData.totalPage,
                "finalPage": bookData.finalPage
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
