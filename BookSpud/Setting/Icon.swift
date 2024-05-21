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
    
    // MARK: - Profile
    case profil = "profil"
    case checkNickname = "nickNameCheck"
    case notCheckNickname = "notNicknameCheck"
    
    // MARK: - BtnImage
    case inputISBN = "inputISBN"
    
    // MARK: - TabImage
    case homeTab = "homeTab"
    case bookTap = "bookTap"
    case isbnTap = "isbnTap"
    case spudTab = "spudTab"
    case reportTab = "reportTab"
    
    case clickedHome = "clickedHome"
    case clickedBook = "clickedBook"
    case clickedISBN = "clickedISBN"
    case clickedSpud = "clickedSpud"
    case clickedReport = "clickedReport"
    
    // MARK: - HomeTap
    
    /* 상단 유저 프로필 정보 이미지 */
    case cutyPotato = "cutyPotato"
    case optionBtn = "optionBtn"
    
    /* 감정 선택 배경 */
    case emotionBackground = "emotionBackground"
    
    /* 감정 피커 종류 */
    case angryEmotion = "angryEmotion"
    case happyEmtion = "happyEmtion"
    case inspirationEmotion = "inspirationEmotion"
    case moveEmotion = "moveEmotion"
    case sadEmotion = "sadEmotion"
    
    /* 감정 구절 */
    case versesBorder = "versesBorder"
    
    /* 감정 구절 책 표지 */
    case emptyBookPoster = "emptyBookPoster"
    
    // MARK: - Function
    var image: Image {
        return Image(self.rawValue)
    }
    
    // MARK: - TabFunction
    func icon(for isSelected: Bool) -> Image {
        let iconName = isSelected ? self.clickedIconName : self.rawValue
        return Image(iconName)
    }
    
    private var clickedIconName: String {
        switch self {
        case .homeTab: return "clickedHome"
        case .bookTap: return "clickedBook"
        case .isbnTap: return "clickedISBN"
        case .spudTab: return "clickedSpud"
        case .reportTab: return "clickedReport"
        default:
            return self.rawValue
        }
    }
}
