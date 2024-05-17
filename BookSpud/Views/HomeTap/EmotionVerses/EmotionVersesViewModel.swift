//
//  EmotionVersesViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/17/24.
//

import Foundation
import SwiftUI

class EmotionVersesViewModel: ObservableObject {
    
    // MARK: - Property
    /* EmotionVerses  Propert */
    @Published var selectedEmotionImage: SwiftUI.Image = Icon.happyEmtion.image
    @Published var isEmotionPickerPresented: Bool = false
}
