//
//  HomeView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/11/24.
//

import SwiftUI

/// 홈탭 모든 뷰 구성
struct HomeView: View {
    
    // MARK: - ViewModel
    @StateObject var topUserViewModel = TopUserViewModel()
    
    var body: some View {
        allView
    }
    
    private var allView: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, content: {
                TopUserView(topUserViewModel: topUserViewModel)
                
                Spacer()
            })
        }
        .ignoresSafeArea(.all)
    }
}

struct HomeView_Preview: PreviewProvider {
    static let devices = ["iPhone 11", "iPhone 15 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            HomeView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
