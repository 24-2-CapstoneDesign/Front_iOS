//
//  ReportView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/11/24.
//

import SwiftUI

struct ReportView: View {
    
    @StateObject var viewModel = ReportViewModel()
    @StateObject var reportDraftViewModel = ReportDraftViewModel()
    @StateObject var selectBookListViewModel = SelectBookListViewModel()
    @State var isShowMakeReport: Bool = false
    
    var body: some View {
        NavigationStack {
            allGroup
        }
        .sheet(isPresented: $isShowMakeReport, content: {
            SelectedBookListView(viewModel: selectBookListViewModel, reportDraftViewModel: reportDraftViewModel)
        })
        .onAppear {
            viewModel.getReportData()
        }
    }
    
    // MARK: - ReportView Group
    private var allGroup: some View {
        VStack(alignment: .center, spacing: 46, content: {
            
            CustomNavigation(title: "독후감", rightPlus: Image(systemName: "plus"), action: {
                isShowMakeReport = true
            })
            
            Spacer()
            
            if viewModel.reportData == nil {
                VStack(alignment: .center, spacing: 15, content: {
                    Icon.sadSpud.image
                        .resizable()
                        .frame(maxWidth: 126, maxHeight: 140)
                        .aspectRatio(contentMode: .fit)
                    Text("등록된 독후감이 없습니다.")
                        .font(.spoqaHans(type: .bold, size: 18))
                        .foregroundStyle(Color.gray06)
                })
                Spacer()
                
            } else {
                ScrollView(.vertical) {
                    LazyVGrid(columns: [GridItem(.flexible(minimum: 0, maximum: 142))], alignment: .center, spacing: 16, pinnedViews: [], content: {
                        ForEach(viewModel.reportData?.result.bookReportResponses ?? [], id: \.self) { report in
                            NavigationLink(destination: DetailReport(viewModel: ReportCardViewModel(bookReportResponse: report), reportDraftViewModel: reportDraftViewModel)) {
                                ReportCardView(viewModel: ReportCardViewModel(bookReportResponse: report))
                            }
                        }
                    })
                    .frame(maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                    .background(Color.backgrounYellow)
                    .ignoresSafeArea()
                    .onAppear {
                        viewModel.getReportData()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .refreshable {
                    viewModel.getReportData()
                }
            }
        })
    }
}

#Preview {
    ReportView()
}
