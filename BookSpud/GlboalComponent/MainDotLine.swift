//
//  dotLine.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import SwiftUI

struct MainDotLine: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}
