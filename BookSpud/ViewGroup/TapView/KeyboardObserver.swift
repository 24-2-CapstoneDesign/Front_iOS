//
//  KeyboardObserver.swift
//  BookSpud
//
//  Created by 정의찬 on 6/12/24.
//

import SwiftUI
import Combine

class KeyboardObserver: ObservableObject {
    @Published var isKeyboardVisible: Bool = false
    private var cancellables = Set<AnyCancellable>()

    init() {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)

        willShow
            .merge(with: willHide)
            .sink { [weak self] notification in
                if notification.name == UIResponder.keyboardWillShowNotification {
                    self?.isKeyboardVisible = true
                } else {
                    self?.isKeyboardVisible = false
                }
            }
            .store(in: &cancellables)
    }
}

