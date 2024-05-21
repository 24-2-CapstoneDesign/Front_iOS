//
//  FirendConnectingData.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import Foundation

struct FriendConnectingData: Codable, Hashable {
    var information: [FriendConnectingDetailData]
}

struct FriendConnectingDetailData: Codable, Hashable {
    var bookCoverUrl: String
    var bookName: String
    var author: String
}


final class sampleDataLists {
    static let datalist = FriendConnectingData(information: [
        FriendConnectingDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791168418011.jpg", bookName: "Book One", author: "Author A"),
        FriendConnectingDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791198517425.jpg", bookName: "Book Two", author: "Author B"),
        FriendConnectingDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791198517425.jpg", bookName: "Book Two", author: "Author C"),
        FriendConnectingDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791198517425.jpg", bookName: "Book Two", author: "Author D")
    ])
}
