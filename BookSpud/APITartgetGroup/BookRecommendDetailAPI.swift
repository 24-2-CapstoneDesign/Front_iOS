//
//  EmotionUserAPI.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya

/// 북투북 세부 정보뷰의 유저 북마크 및 책정보 API 타겟
enum BookRecommendDetailAPI {
    case emotionBookMark(id: Int) /* 책 id */
    case detailBookInfo(id: Int) /* 책 id */
}

extension BookRecommendDetailAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .emotionBookMark(let id):
            return "/api/bookmark/\(id)/others"
        case .detailBookInfo(let id):
            return "/api/book/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .emotionBookMark:
            return .get
        case .detailBookInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .emotionBookMark:
            return .requestPlain
        case .detailBookInfo:
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
        case .emotionBookMark(let id):
            let sampleJSON: String
            switch id {
            case 1:
                sampleJSON = """
                   {
                       "status": 200,
                       "message": "북마크 정보",
                       "result": [
                           {
                               "bookId": \(id),
                               "title": "Happy Book",
                               "author": "Author A",
                               "cover": "https://example.com/cover1.jpg"
                           }
                       ]
                   }
                   """
            case 2:
                sampleJSON = """
                   {
                       "status": 200,
                       "message": "북마크 정보",
                       "result": [
                           {
                               "bookId": \(id),
                               "title": "Sad Book",
                               "author": "Author B",
                               "cover": "https://example.com/cover2.jpg"
                           }
                       ]
                   }
                   """
            default:
                sampleJSON = """
                   {
                       "status": 200,
                       "message": "북마크 정보",
                       "result": [
                           {
                               "bookId": \(id),
                               "title": "Default Book",
                               "author": "Default Author",
                               "cover": "https://example.com/default_cover.jpg"
                           }
                       ]
                   }
                   """
            }
            return Data(sampleJSON.utf8)
            
        case .detailBookInfo(let id):
            let sampleJSON: String
            switch id {
            case 1:
                sampleJSON = """
                   {
                       "status": 200,
                       "message": "책 정보",
                       "result": {
                           "title": "리틀 라이프1",
                           "author": "한야",
                           "cover": "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788952776372.jpg",
                           "price": 16000,
                           "salePrice": 14900,
                           "content": "한야 야나기하라의 장편소설『리틀 라이프』. 어린 시절 끔찍한 학대와 폭력의 트라우마를 간직한 비밀스러운 인물 주드의 이야기가 펼쳐진다. 자신에게 주어진 삶의 부당함을 넘어서려 했던 남자, 살아내기 위해 스스로를 파괴해야 했던 한 남자의 삶을 그린 이 작품은, 한 가닥 희망의 가능성마저 거부하며 생의 고통을 정면으로 마주하게 한다.",
                           "purchaseLink": "https://product.kyobobook.co.kr/detail/S000000733954"
                       }
                   }
                   """
            case 2:
                sampleJSON = """
                   {
                       "status": 200,
                       "message": "책 정보",
                       "result": {
                           "title": "불변의 법칙",
                           "author": "모건 하우절",
                           "cover": "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791198517425.jpg",
                           "price": 15000,
                           "salePrice": 12000,
                           "content": "세계적인 베스트셀러 《돈의 심리학》의 저자 모건 하우절이 3년 만에 세상에 내놓은 신작.‘절대 변하지 않는 것들에 대한 23가지 이야기’를 전한다. 출간하자마자 아마존과 뉴욕타임스 베스트셀러 자리에 오르며 아마존 독자들과 오피니언 리더들의 극찬을 받았다.",
                           "purchaseLink": "https://example.com/purchase2"
                       }
                   }
                   """
            default:
                sampleJSON = """
                   {
                       "status": 200,
                       "message": "책 정보",
                       "result": {
                           "title": "Default Detailed Book",
                           "author": "Default Author",
                           "cover": "https://example.com/default_cover.jpg",
                           "price": 20000,
                           "salePrice": 16000,
                           "content": "This is the default content.",
                           "purchaseLink": "https://example.com/default_purchase"
                       }
                   }
                   """
            }
            return Data(sampleJSON.utf8)
        }
    }
}
