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
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791192237022.jpg", bookName: "고민의 답", bookAuthor: "강한별", bookCurrentPage: 0, bookTotalPage: 324, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788954695053.jpg", bookName: "아주 희미안 빛으로도", bookAuthor: "최은영", bookCurrentPage: 0, bookTotalPage: 324, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791167372864.jpg", bookName: "구의 증명", bookAuthor: "최진영", bookCurrentPage: 0, bookTotalPage: 324, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791160405750.jpg", bookName: "단 한 사람", bookAuthor: "최진영", bookCurrentPage: 0, bookTotalPage: 300, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788952776372.jpg", bookName: "리틀 라이프 1", bookAuthor: "한야 야나기할", bookCurrentPage: 0, bookTotalPage: 424, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791198517425.jpg", bookName: "불변의 법칙", bookAuthor: "모건 하우절 저자", bookCurrentPage: 0, bookTotalPage: 284, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791171711673.jpg", bookName: "하루 한 장 나의 어휘력을 위한 필사 노트", bookAuthor: "유선경", bookCurrentPage: 0, bookTotalPage: 124, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788934981770.jpg", bookName: "고민과 소설가", bookAuthor: "유선경", bookCurrentPage: 0, bookTotalPage: 224, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791190908887.jpg", bookName: "오늘 기분은 카레", bookAuthor: "서궁", bookCurrentPage: 0, bookTotalPage: 412, bookMarkCount: 23),
        
        
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791161110165.jpg", bookName: "허리 아래 고민에 답변 드립니다.", bookAuthor: "우에노 지즈코", bookCurrentPage: 130, bookTotalPage: 324, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791159254178.jpg", bookName: "답은 나에게 있어", bookAuthor: "우에노 지즈코", bookCurrentPage: 320, bookTotalPage: 324, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788960513303.jpg", bookName: "직장인 고민 답은 이미 나와 있다", bookAuthor: "니시우치 히로무", bookCurrentPage: 52, bookTotalPage: 324, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788989518372.jpg", bookName: "우리 아기 홈닥터", bookAuthor: "우에노 지즈코", bookCurrentPage: 231, bookTotalPage: 324, bookMarkCount: 23),
        BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791188915149.jpg", bookName: "육아 고민? 기질 육아가 답", bookAuthor: "최은정", bookCurrentPage: 12, bookTotalPage: 324, bookMarkCount: 23),
        
        
    ])
}
