//
//  SelectedBookListView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//


import SwiftUI

/// 독후감 생성 전 전체 책 조회 뷰
struct SelectedBookListView: View {
    
    @StateObject var viewModel: SelectBookListViewModel
    
    // MARK: - Init
    
    init() {
        self._viewModel = StateObject(wrappedValue: SelectBookListViewModel())
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center, content: {
                topNavigation
                
                Spacer()
                
                gridView
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgrounYellow)
            .ignoresSafeArea(.all)
            .onAppear{
                viewModel.getBookList()
            }
        }
        
    }
    
    /// 상단 네비게이션
    private var topNavigation: some View {
        CustomNavigation(title: "책 선택", onOff: true)
    }
    
    private var gridView: some View {
        ScrollView(.vertical, content: {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 0, maximum: 184), spacing: 38), count: 3), spacing: 20, content: {
                ForEach(viewModel.bookListBookData?.result.myBooks ?? [], id: \.self) { bookData in
                    NavigationLink(destination: ReportDraftView(bookData: bookData)) {
                        SelectBookListCard(bookData: bookData)
                    }
                }
            })
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SelectedBookListView_Preview: PreviewProvider {
    static var previews: some View {
        SelectedBookListView()
    }
}
