//
//  FirendConnectingData.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import Foundation

struct BookRecommendData: Codable, Hashable {
    var information: [BookRecommendDetailData]
}

struct BookRecommendDetailData: Codable, Hashable {
    var bookCoverUrl: String
    var bookName: String
    var author: String
}


final class sampleDataLists {
    static let datalist = BookRecommendData(information: [
        BookRecommendDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791168418011.jpg", bookName: "Book One", author: "Author A"),
        BookRecommendDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791198517425.jpg", bookName: "Book Two", author: "Author B"),
        BookRecommendDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791198517425.jpg", bookName: "Book Two", author: "Author C"),
        BookRecommendDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791198517425.jpg", bookName: "Book Two", author: "Author D")
    ])
}
