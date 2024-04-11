//
//  FontExtension.swift
//  BookSpud
//
//  Created by 정의찬 on 4/12/24.
//

import Foundation
import SwiftUI

extension Font {
    enum SpoqaHanSans {
        case bold
        case light
        case medium
        case regular
        case thin
        
        var value: String {
            switch self {
            case .bold:
                return "SpoqaHanSansNeo-Bold"
            case .light:
                return "SpoqaHanSansNeo-Light"
            case .medium:
                return "SpoqaHanSansNeo-Medium"
            case .regular:
                return "SpoqaHanSansNeo-Regular"
            case .thin:
                return "SpoqaHanSansNeo-Thin"
            }
        }
    }
    
    static func spoqaHans(type: SpoqaHanSans, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
}
