//
//  BookView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/11/24.
//

import SwiftUI

struct BookListView: View {
    
    @State var selectedStatus: ReadingStatus = .nonStarted
    
    var body: some View {
        VStack(alignment: .center, content: {
            bookListNavigation
            Spacer()
        })
        .ignoresSafeArea(.all)
        .background(Color.backgrounYellow)
    }
    
    
    // MARK: - BookListView
    
    /// 책 정보 상단 네비게이션
    private var bookListNavigation: some View {
        ZStack(alignment: .bottom, content: {
            TopRadiusView(radius: 0, height: 140)
            topNavigation
        })
        .frame(maxWidth: .infinity, maxHeight: 140)
    }
    
    ///
    private var topNavigation: some View {
        VStack(alignment: .leading, spacing: 21, content: {
            
            
            navigationTitle
            
            
            bookListSortBtn
        })
        .frame(maxWidth: 430)
    }
    
    /// 책 정보 상단 네비게이션
    private var navigationTitle: some View {
        HStack(alignment: .center, content: {

            Spacer()
            
            Text("책 정보")
                .font(.pretendard(type: .bold, size: 16))
                .kerning(-0.5)
            
            Spacer()
        })
        .frame(maxHeight: 40)
    }
    
    /// 책 정보 상태
    private var bookListSortBtn: some View {
        HStack(alignment: .bottom, spacing: 10, content: {
            BookStatusBtn(text: ReadingStatus.nonStarted.rawValue,
                         action: {
                selectedStatus = .nonStarted
            },
                         currentStatus: .nonStarted,
                         selected: $selectedStatus)
            
            BookStatusBtn(text: ReadingStatus.reading.rawValue,
                         action: {
                selectedStatus = .reading
            },
                         currentStatus: .reading,
                         selected: $selectedStatus)

            BookStatusBtn(text: ReadingStatus.completed.rawValue,
                         action: {
                selectedStatus = .completed
            },
                         currentStatus: .completed,
                         selected: $selectedStatus)
        })
        .frame(maxWidth: 430, alignment: .leading)
        .padding(.leading, 20)
    }
}

#Preview {
    BookListView()
}
