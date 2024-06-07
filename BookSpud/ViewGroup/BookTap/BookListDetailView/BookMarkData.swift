//
//  BookListDetailData.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import Foundation

struct BookMarkData: Codable, Hashable {
    var status: Int
    var message: String
    var result: [BookMarkDetailData]
}

struct BookMarkDetailData: Codable, Hashable {
    var bookMarkId: Int
    var phase: String
    var page: Int
    var memo: String
    var emotion: String
}


struct BookPageData: Codable {
    var status: Int
    var message: String
}
