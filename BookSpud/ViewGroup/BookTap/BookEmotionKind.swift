//
//  BookEmotionKind.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import Foundation

enum BookEmotionKind: String {
    case happy = "기쁨"
    case sad = "슬픔"
    case angry = "분노"
    case inspiration = "영감"
    case move = "감동"
    
    var emotionKey: String {
           switch self {
           case .happy:
               return "JOY"
           case .sad:
               return "SADNESS"
           case .angry:
               return "ANGER"
           case .inspiration:
               return "INSPIRATION"
           case .move:
               return "MOVED"
           }
       }
}
