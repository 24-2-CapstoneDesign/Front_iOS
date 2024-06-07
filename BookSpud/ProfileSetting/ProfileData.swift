//
//  ProfilModel.swift
//  BookSpud
//
//  Created by 정의찬 on 4/13/24.
//

import Foundation

// MARK: - ProfileModel

struct NickNameData: Codable {
    var status: Int
    var message: String
}

// MARK: - ProfileImage

struct ProfileImageData: Codable {
    var status: Int
    var message: String
    var result : DetailProfilImageData
}


struct DetailProfilImageData: Codable {
    var profileImageUrl: String
}
