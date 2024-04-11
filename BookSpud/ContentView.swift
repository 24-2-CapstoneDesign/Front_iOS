//
//  ContentView.swift
//  BookSpud
//
//  Created by 정의찬 on 4/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("백두산")
                .font(.spoqaHans(type: .medium, size: 40))
        }
        .onAppear {
            for fontFamily in UIFont.familyNames {
                for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
                    print(fontName)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
