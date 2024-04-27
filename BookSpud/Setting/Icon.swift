//
//  Icon.swift
//  BookSpud
//
//  Created by 정의찬 on 4/12/24.
//

import Foundation
import SwiftUI

enum Icon: String {
    // MARK: - Login
    case logo = "logo"
    case kakao = "kakaoLogin"
    case apple = "iosLogin"
    
    // MARK: - Profil
    case profil = "profil"
    case checkNickname = "nickNameCheck"
    case notCheckNickname = "notNicknameCheck"
    
    // MARK: - BtnImage
    case inputISBN = "inputISBN"
    
    // MARK: - Function
    var image: Image {
        return Image(self.rawValue)
    }
}
