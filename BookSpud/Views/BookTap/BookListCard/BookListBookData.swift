//
//  BookListBookData.swift
//  BookSpud
//
//  Created by 정의찬 on 6/2/24.
//

import Foundation

struct BookListBookData {
    var information: [BookListDetailData]
}

struct BookListDetailData {
    var bookCover: String
    var bookName: String
    var bookAuthor: String
    var bookCurrentPage: Int
    var bookTotalPage: Int
}
