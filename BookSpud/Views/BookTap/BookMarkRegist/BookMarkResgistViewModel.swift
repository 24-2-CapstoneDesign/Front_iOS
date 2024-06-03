//
//  BookMarkResgistViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import Foundation


class BookMarkResgistViewModel: ObservableObject {
    @Published var versesText: String = ""
    @Published var memoText: String = ""
    @Published var isShowOCR: Bool = false
}
