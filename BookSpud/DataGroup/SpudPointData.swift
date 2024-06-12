//
//  SpudPointData.swift
//  BookSpud
//
//  Created by 정의찬 on 6/12/24.
//

import Foundation


struct SpudPointData: Codable {
    var status: Int
    var message: String
    var result: SpudPointDataResult
}

struct SpudPointDataResult: Codable {
    var id: Int
    var point: Int
}
