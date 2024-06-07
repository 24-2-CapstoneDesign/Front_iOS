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
        Text(name)
            .font(.spoqaHans(type: .bold, size: 12))
            .frame(maxWidth: 42, maxHeight: 21)
            .foregroundStyle(Color.white)
            .background(backgroundColor(name))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.clear)
            )
            .clipShape(.rect(cornerRadius: 25))
            
    }
    
    private func backgroundColor(_ name: String) -> Color {
        switch name {
        case "초안":
            return Color.errorDefault
        case "완료":
            return Color.successDefault
        default:
            return Color.errorDefault
        }
    }
}


struct ReportTagComponent_Preview: PreviewProvider {
    static var previews: some View {
        ReportTagComponent(name: "초안")
    }
}
