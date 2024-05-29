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

struct BookRecommendDetailData: Codable, Hashable{
    var bookCoverUrl: String
    var bookName: String
    var author: String
    var subject: String
    var price: Int
    var introduce: String
    var purchaseURL: String
}


final class sampleDataLists {
    static let datalist = BookRecommendData(information: [
        BookRecommendDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791168418011.jpg", bookName: "Book One", author: "Author A", subject: "소설노잼", price: 12800, introduce: "하하하하하 재밌어요!!", purchaseURL: "https://www.naver.com")
    ])
    
}
