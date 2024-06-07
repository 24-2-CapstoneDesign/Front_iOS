//
//  BookListBookData.swift
//  BookSpud
//
//  Created by 정의찬 on 6/2/24.
//

import Foundation

struct BookListBookData: Codable, Hashable {
    var status: Int
    var message: String
    var result: BookListMyBooks
}

struct BookListMyBooks: Codable, Hashable {
    var myBooks: [BookListDetailData]
}

struct BookListDetailData: Codable, Hashable {
    var myBookId: Int
    var title: String
    var author: String
    var cover: String
    var updatedAt: String
    var totalPage: Int
    var finalPage: Int
    
    var readingProgress: Double {
            guard totalPage > 0 else { return 0 }
            return Double(finalPage) / Double(totalPage)
        }
    
    init(myBookId: Int = 0, title: String = "", author: String = "", cover: String = "", updatedAt: String = "", totalPage: Int = 0, finalPage: Int = 0) {
            self.myBookId = myBookId
            self.title = title
            self.author = author
            self.cover = cover
            self.updatedAt = updatedAt
            self.totalPage = totalPage
            self.finalPage = finalPage
        }
}

