//
//  BookReadProgressView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/2/24.
//

import SwiftUI

/// 내가 저장한 책 리스트 진행률 컴포넌트
struct BookReadProgressView: View {
    
    let currentPage: Int
    let totalPage: Int
    
    init(bookData: BookListDetailData) {
        self.currentPage = bookData.finalPage
        self.totalPage = bookData.totalPage
    }
    
    
    var body: some View {
        ZStack {
            backgroundView
            progressView
            progressText
        }
        .frame(maxWidth: 145, maxHeight: 23)
        
    }
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(
                Color.primary1
            )
            .frame(maxWidth: 145, maxHeight: 23)
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
    
    private var progressText: some View {
        HStack(alignment: .center, spacing: 60, content: {
            readStatus()
                .font(.spoqaHans(type: .regular, size: 10))
                .kerning(-0.2)
                .foregroundStyle(.white)
            
            
            Text("\(percentage())%")
                .font(.spoqaHans(type: .regular, size: 10))
                .foregroundStyle(.white)
        })
        .frame(maxWidth: 139)
    }
    
    private func percentage() -> Int {
        let current = self.currentPage
        let total = self.totalPage
        
        guard total > 0 else { return 0 }
        
        return (current * 100) / total
    }
    
    
    // MARK: - TextFunction
    private func readStatus() -> Text {
        let percent = percentage()
        
        if percent == 0 {
            return Text("준비 중")
        } else if percent > 0 && percent < 100{
            return Text("읽는 중")
        } else {
            return Text("완독📖")
        }
    }
}
