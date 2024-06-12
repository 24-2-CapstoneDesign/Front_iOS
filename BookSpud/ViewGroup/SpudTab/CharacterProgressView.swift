//
//  CharacterProgressView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/12/24.
//

import SwiftUI


struct CharacterProgressView: View {
    
    let currentPoint: Int
    let totalPoint: Int
    let maxWidth: CGFloat
    let maxHeight: CGFloat
    
    init(currentPoint: Int,
         totalPoint: Int,
         maxWidth: CGFloat = 145,
         maxHeight: CGFloat = 32
    ) {
        self.currentPoint = currentPoint
        self.totalPoint = totalPoint
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
    }
    
    var body: some View {
        ZStack {
            backgroundView
            progressView
            progressTitle
        }
        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
    }
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(
                Color.primary1
            )
            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
            .shadow03()
    }
    
    
    /// 진행 중인 프로그레스 색뷰
    private var progressView: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let progress = CGFloat(percentage()) / 100
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.primaryDark)
                .frame(width: width * progress)
        }
    }
    
    private var progressTitle: some View {
        HStack(alignment: .center, spacing: 10, content: {
            Text("\(percentage())%")
                .font(.spoqaHans(type: .bold, size: 14))
                .foregroundStyle(Color.warningLight)
        })
    }
    
    
    private func percentage() -> Int {
        let current = self.currentPoint
        let total = self.totalPoint
        
        guard total > 0 else { return 0 }
        
        return (current * 100) / total
    }
    
    
    
}


struct CharacterProgress_Preview: PreviewProvider {
    static var previews: some View {
        CharacterProgressView(currentPoint: 20, totalPoint: 300, maxWidth: 145, maxHeight: 23)
    }
}
