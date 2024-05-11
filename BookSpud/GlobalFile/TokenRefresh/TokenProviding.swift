//
//  TokenProviding.swift
//  BookSpud
//
//  Created by 정의찬 on 5/11/24.
//

import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}
