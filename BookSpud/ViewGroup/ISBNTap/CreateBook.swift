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
            return .requestParameters(parameters: [
                "isbn": bookData.documents.first?.isbn ?? "",
                "title": bookData.documents.first?.title ?? "",
                "author": bookData.documents.first?.authors.first ?? "",
                "cover": bookData.documents.first?.thumbnail ?? 0,
                "price": bookData.documents.first?.price ?? 0,
                "salePrice": bookData.documents.first?.salePrice ?? 0,
                "content": bookData.documents.first?.contents ?? "",
                "purchaseLink": bookData.documents.first?.url ?? ""
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
