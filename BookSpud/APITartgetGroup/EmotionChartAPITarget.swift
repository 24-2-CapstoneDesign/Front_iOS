//
//  EmotionAPITarget.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya

enum EmotionChartAPITarget {
    case getChart
}

extension EmotionChartAPITarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .getChart:
            return "/api/bookmark/count" //감정 차트 북마크 갯수 조회
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getChart:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getChart:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "accept": "*/*"
        ]
    }
    
    var sampleData: Data {
        switch self {
        case .getChart:
            let sampleJSON = """
                {
                  "status": 200,
                  "message": "성공",
                  "result": {
                    "JOY": 12,
                    "SADNESS": 2,
                    "ANGER": 1,
                    "INSPIRATION": 4,
                    "MOVED": 13
                  }
                }
                """
            
            return Data(sampleJSON.utf8)
        }
    }
}
