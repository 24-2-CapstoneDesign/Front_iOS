//
//  CreateBook.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya

enum CreateBook {
    case createBook(bookData: ScanBookData)
}

extension CreateBook: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .createBook:
            return "/api/book"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createBook:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .createBook(let bookData):
            return .requestParameters(parameters: bookData.toParameters(), encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "accept": "*/*"
        ]
    }
}
