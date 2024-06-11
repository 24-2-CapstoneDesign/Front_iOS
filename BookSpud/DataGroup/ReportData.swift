//
//  ReportData.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation



/// 독후감 전체 데이터 받아오기
struct ReportData: Codable, Hashable {
    var status: Int
    var message: String
    var result: BookReportResult
}

struct BookReportResult: Codable, Hashable {
    var bookReportResponses: [BookReportResponse]
}

struct BookReportResponse: Codable, Hashable {
    var bookReportId: Int
    var cover: String
    var title: String
    var updatedAt: String
    var argument: String
    var status: String
}
