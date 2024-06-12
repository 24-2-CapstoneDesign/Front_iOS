//
//  GetPoinAPITarget.swift
//  BookSpud
//
//  Created by 정의찬 on 6/12/24.
//

import Foundation
import Moya

enum GetPoinAPITarget {
    case getPoint
}

extension GetPoinAPITarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.bookspud.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .getPoint:
            return "/api/user/point"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPoint:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPoint:
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
        case .getPoint:
            let jsonData = """
                    {
                      "status": 0,
                      "message": "string",
                      "result": {
                        "id": 2,
                        "point": 210
                      }
                    }
                    """
            
            return Data(jsonData.utf8)
        }
    }
}
