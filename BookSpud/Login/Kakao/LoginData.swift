//
//  LoginData.swift
//  BookSpud
//
//  Created by 정의찬 on 6/6/24.
//

import Foundation


struct LoginData: Codable {
    var message: String
    var data: LoginDetailData
}

struct LoginDetailData: Codable {
    var accessToken: String
    var refreshToken: String
}
