//
//  ISBNInputViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/30/24.
//

import Foundation

class ISBNInputViewModel: ObservableObject {
    @Published var isbnText: String = "" {
        didSet {
            if !isbnText.isEmpty {
                isbnTextClicked = true
            } else {
                isbnTextClicked = false
            }
        }
    }
    @Published var isbnTextClicked: Bool = false
}
