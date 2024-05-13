//
//  ProfileAPITarget.swift
//  BookSpud
//
//  Created by 정의찬 on 5/14/24.
//

import Foundation
import Moya

enum HomeUserInfoAPITarget {
    case getProfileInfo
}

extension HomeUserInfoAPITarget : TargetType {
    var baseURL: URL {
        return url
    }
}
