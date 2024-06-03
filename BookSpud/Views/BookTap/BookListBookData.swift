//
//  BookListBookData.swift
//  BookSpud
//
//  Created by 정의찬 on 6/2/24.
//

import Foundation

struct BookListBookData: Hashable {
    var information: [BookListDetailData]
}

struct BookListDetailData: Hashable {
    var bookCover: String
    var bookName: String
    var bookAuthor: String
    var bookCurrentPage: Int
    var bookTotalPage: Int
    var bookMarkCount: Int
    
    var readingProgress: Double {
            guard bookTotalPage > 0 else { return 0 }
            return Double(bookCurrentPage) / Double(bookTotalPage)
        }
}

final class dataList {
    static let data: BookListBookData = BookListBookData(information: [
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788954695053.jpg", bookName: "아주 희미안 빛으로도", bookAuthor: "최은영", bookCurrentPage: 324, bookTotalPage: 324, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791167372864.jpg", bookName: "구의 증명", bookAuthor: "최진영", bookCurrentPage: 24, bookTotalPage: 324, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791160405750.jpg", bookName: "단 한 사람", bookAuthor: "최진영", bookCurrentPage: 14, bookTotalPage: 300, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788952776372.jpg", bookName: "리틀 라이프 1", bookAuthor: "한야 야나기할", bookCurrentPage: 234, bookTotalPage: 424, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791198517425.jpg", bookName: "불변의 법칙", bookAuthor: "모건 하우절 저자", bookCurrentPage: 243, bookTotalPage: 284, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791171711673.jpg", bookName: "하루 한 장 나의 어휘력을 위한 필사 노트", bookAuthor: "유선경", bookCurrentPage: 2, bookTotalPage: 124, bookMarkCount: 23)
    ])
}
