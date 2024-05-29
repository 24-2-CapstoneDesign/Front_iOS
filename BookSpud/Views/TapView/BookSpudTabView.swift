//
//  BookSpudTabView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/11/24.
//

import SwiftUI

struct BookSpudTabView: View {
    
    // MARK: - Property
    @State private var selectedTab: BookSpudTab = .homeTab
    @State private var opacity = 0
    
    // MARK: - Init
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Icon.homeTab.image
                            .fixedSize()
                            .aspectRatio(contentMode: .fit)
                    }
                    .tag(BookSpudTab.homeTab)
                
                BookView()
                    .tabItem {
                        Icon.bookTap.image
                            .fixedSize()
                            .aspectRatio(contentMode: .fit)
                    }
                    .tag(BookSpudTab.bookTap)
                
                ISBNCameraView()
                    .tabItem {
                        Icon.isbnTap.image
                            .fixedSize()
                            .aspectRatio(contentMode: .fit)
                    }
                    .tag(BookSpudTab.isbnTap)
                
                SpudView()
                    .tabItem {
                        Icon.spudTab.image
                            .fixedSize()
                            .aspectRatio(contentMode: .fit)
                    }
                    .tag(BookSpudTab.spudTab)
                
                ReportView()
                    .tabItem{
                        Icon.reportTab.image
                            .fixedSize()
                            .aspectRatio(contentMode: .fit)
                    }
                    .tag(BookSpudTab.reportTab)
            }
            
            
            CustomTabView(selectedTab: $selectedTab)
        })
        .opacity(0)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                self.opacity = 1
            }
        }
    }
}

struct BookSpudTabView_Previews: PreviewProvider {
    static let devices = ["iPhone 11", "iPhone 15 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            BookSpudTabView()
                .previewLayout(.sizeThatFits)
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
