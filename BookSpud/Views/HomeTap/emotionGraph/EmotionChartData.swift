//
//  EmotionData.swift
//  BookSpud
//
//  Created by 정의찬 on 5/22/24.
//

import Foundation
import SwiftUI

struct EmotionChartData: Identifiable {
    var id = UUID()
    let name: String
    let value: Int
    let color: Color
}
