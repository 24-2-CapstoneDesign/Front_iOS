//
//  TopRadiusView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/11/24.
//

import SwiftUI

/// 상단 곡선 뷰
struct TopRadiusView: View {
    
    // MARK: - Property
    public var radius: CGFloat
    public var height: CGFloat
    
    
    // MARK: - Init
    init(radius: CGFloat, height: CGFloat) {
        self.radius = radius
        self.height = height
    }
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { geo in
            Rectangle()
                .fill(Color.primary1)
                .frame(maxWidth: geo.size.width, maxHeight: height)
                .roundedCorner(radius, corners: [.bottomLeft, .bottomRight])
                .ignoresSafeArea(.all)
        }
    }
}

struct TopRadiusView_Preview: PreviewProvider {
    static let devices = ["iPhone 11", "iPhone 15 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            TopRadiusView(radius: 50, height: 160)
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
