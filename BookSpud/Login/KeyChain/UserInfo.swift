//
//  UserInfo.swift
//  BookSpud
//
//  Created by 정의찬 on 4/29/24.
//

import Foundation

struct UserInfo: Codable {
    var accessToken: String?
    var refreshToken: String?
    var nickname: String?
}
