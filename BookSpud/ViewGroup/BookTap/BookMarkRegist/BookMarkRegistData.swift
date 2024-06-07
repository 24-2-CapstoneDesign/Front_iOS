//
//  BookMarkRegistData.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation

struct BookMarkRegistData:Codable {
    var phase: String
    var page: Int
    var memo: String
    var emotion: String
}

struct ResponseBookMarkRegist:Codable {
    var status: Int
    var message: String
    var result: BookMarkID
}

struct BookMarkID:Codable {
    var bookMarkId: Int
}
