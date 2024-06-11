//
//  ReportTagView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/5/24.
//

import SwiftUI

struct ReportTagComponent: View {
    
    var name: String
    
    var body: some View {
        Text(retunStatus(name: name))
            .font(.spoqaHans(type: .bold, size: 12))
            .frame(maxWidth: 42, maxHeight: 21)
            .foregroundStyle(Color.white)
            .padding(.all, 5)
            .background(backgroundColor(name))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.clear)
            )
            .clipShape(.rect(cornerRadius: 25))
            
    }
    
    /// 상태에 따른 배경색 전달
    /// - Parameter name: 상태 값 이름
    /// - Returns: 상태값에 따른 색상 전달
    private func backgroundColor(_ name: String) -> Color {
        switch name {
        case "DRAFT":
            return Color.errorDefault
        case "FINAL":
            return Color.successDefault
        default:
            return Color.errorDefault
        }
    }
    
    /// 독후감 상태에 따른 텍스트 반환
    /// - Parameter name: 상태값 영어 텍스트
    /// - Returns: 상태값에 맞는 텍스트 값 전달
    private func retunStatus(name: String) -> String {
        switch name {
        case "DRAFT":
            return "초안"
        case "FINAL":
            return "최종"
        default:
            return "빈값"
        }
    }
}


struct ReportTagComponent_Preview: PreviewProvider {
    static var previews: some View {
        ReportTagComponent(name: "DRAFT")
    }
}
