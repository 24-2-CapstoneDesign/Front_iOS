//
//  ReportAPITarget.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya

enum ReportAPITarget {
    case getReport // 독후감 전체 조회 API
    case getDraft(id: Int)
    case postDraft(id: Int, argument: String)
    case getQuestion(id: Int)
    case makeDraft(id: Int, data: MakeDraft)
    case detailBookreport(id: Int)
}

extension ReportAPITarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .getReport:
            return "/api/bookreport"
        case .getDraft(let id):
            return "/api/bookreport/\(id)/argument"
        case .postDraft(let id, _):
            return "/api/bookreport/\(id)/argument"
        case .getQuestion(let id):
            return "/api/bookreport/\(id)/question"
        case .makeDraft(let id,_):
            return "/api/bookreport/\(id)/draft"
        case .detailBookreport(let id):
            return "/api/bookreport/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getReport:
            return .get
        case .getDraft:
            return .get
        case .postDraft:
            return .post
        case .getQuestion:
            return .get
        case .makeDraft:
            return .post
        case .detailBookreport:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getReport:
            return .requestPlain
        case .getDraft:
            return .requestPlain
        case .postDraft(_, let argument):
            return .requestParameters(parameters: ["argument": argument], encoding: JSONEncoding.default)
        case .getQuestion:
            return .requestPlain
        case .makeDraft(_, let data):
            return .requestParameters(parameters: [
                "introQuestion": data.introQuestion,
                "introAnswer": data.introAnswer,
                "bodyQuestion": data.bodyQuestion,
                "bodyAnswer": data.bodyAnswer,
                "conclusionQuestion": data.conclusionQuestion,
                "conclusionAnswer": data.conclusionAnswer
            ], encoding: JSONEncoding.default)
        case .detailBookreport:
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
        case .getReport:
            let jsonData = """
            {
              "status": 200,
              "message": "성공",
              "result": {
                "bookReportResponses": [
                  {
                    "bookReportId": 1,
                    "cover": "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791188331796.jpg",
                    "title": "돈의 속성",
                    "updatedAt": "2024",
                    "argument": "우리의 마음",
                    "status": "BLANK"
                  }
                ]
              }
            }
            """
            return Data(jsonData.utf8)
            
        default:
            let jsonData =
            """
            """
            return Data(jsonData.utf8)
        }
    }
}
