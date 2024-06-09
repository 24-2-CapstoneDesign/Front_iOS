//
//  BookRecommendAPI.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya

enum BookToBook {
    case bookTobook // 북투북 추천책 리스트 받아오기 API
    
}


extension BookToBook: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .bookTobook:
            return "/api/recent/book"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bookTobook:
            return .get
            
        }
    }
    
    var task: Task {
        switch self {
        case .bookTobook:
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
        case .bookTobook:
            let sampleJSON = """
                {
                  "status": 200,
                  "message": "북투북 받아오기 성공",
                  "result": {
                    "myBooks": [
                          {
                            "bookId": 1,
                            "title": "리틀 라이프1",
                            "author": "한야",
                            "cover": "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788952776372.jpg"
                          },
                                  {
                                    "bookId": 2,
                                    "title": "불변의 법칙",
                                    "author": "모건 하우절",
                                    "cover": "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791198517425.jpg"
                                  },
                                  {
                                    "bookId": 3,
                                    "title": "나를 소모하지 않는 현명한 태도",
                                    "author": "마티아스",
                                    "cover": "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791198682505.jpg"
                                  },
                                  {
                                    "bookId": 4,
                                    "title": "마흔에 읽은 쇼펜",
                                    "author": "강용수",
                                    "cover": "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791192300818.jpg"
                                  },
            
                    ]
                  }
                }
            """
            return Data(sampleJSON.utf8)
        }
    }
}
