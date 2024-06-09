//
//  FirendConnectingData.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import Foundation

// MARK: - BookToBook
struct BookRecommendData: Codable, Hashable {
    var status: Int
    var message: String
    var result: MyBooks
}

struct MyBooks: Codable, Hashable {
    var myBooks: [BookRecommendDetailData]
}

struct BookRecommendDetailData: Codable, Hashable{
    var bookId: Int
    var title: String
    var author: String
    var cover: String
}

// MARK: - Detail BookToBook

struct IndividualBookData: Codable {
    var status: Int
    var message: String
    var result: DetailIndividualBookData
}

struct DetailIndividualBookData: Codable {
    var title: String
    var author: String
    var cover: String
    var price: Int
    var salePrice: Int
    var content: String
    var purchaseLink: String
}
