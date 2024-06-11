//
//  BookListDetailData.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import Foundation

// MARK: - BookMarkReading

struct BookMarkData: Codable, Hashable {
    var status: Int
    var message: String
    var result: [BookMarkDetailData]
}

struct BookMarkDetailData: Codable, Hashable, Identifiable {
    var id: Int { bookMarkId }
    var bookMarkId: Int
    var phase: String
    var page: Int
    var memo: String
    var emotion: String
}

// MARK: - PageUpdate

struct BookPageData: Codable {
    var status: Int
    var message: String
}


// MARK: - IndividualBookMark
struct IndividualBookMark: Codable {
    var status: Int
    var message: String
    var result: BookMarkDetailData
}
