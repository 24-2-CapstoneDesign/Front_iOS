//
//  ProfileViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 4/27/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    // MARK: - Property
    
    @Published public var nickNameText: String = "" {
        didSet {
            if nickNameText.count >= 3 {
                beginBtn = true
            } else {
                beginBtn = false
            }
        }
    }
    
    @Published public var beginBtn: Bool = false
}
