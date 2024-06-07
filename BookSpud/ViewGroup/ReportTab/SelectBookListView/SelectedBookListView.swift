//
//  SelectedBookListView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//


import SwiftUI

struct SelectedBookListView: View {
    
    @StateObject var viewModel: SelectBookListViewModel
    @StateObject var reportDraftViewModel: ReportDraftViewModel
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center, content: {
                topNavigation
                
                Spacer()
                
                gridView
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .onAppear{
                viewModel.getBookList()
            }
        }
        
    }
    
    private var topNavigation: some View {
        CustomNavigation(title: "책 선택", onOff: false)
    }
    
    private var gridView: some View {
        ScrollView(.vertical, content: {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 0, maximum: 184), spacing: 38), count: 3), spacing: 20, content: {
                ForEach(viewModel.bookListBookData?.result.myBooks ?? [], id: \.self) { information in
                    NavigationLink(destination: ReportDraftView(viewModel: ReportDraftViewModel(data: information))) {
                        SelectBookListCard(viewModel: IndividualSelectBookViewModel(data: information))
                    }
                }
            })
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
