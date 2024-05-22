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
    
    
    enum GangwonEduSaeeum {
        case basic
        
        var value: String {
            switch self {
            case .basic:
                return "GangwonEduSaeeum-OTFMedium"
            }
        }
    }
    
    static func spoqaHans(type: SpoqaHanSans, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    
    static func gangwonEdu(type: GangwonEduSaeeum, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
}
