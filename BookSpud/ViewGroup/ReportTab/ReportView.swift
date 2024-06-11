//
//  ReportView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/11/24.
//

import SwiftUI

/// 독후감 전체 조회 뷰
struct ReportView: View {
    
    @StateObject var viewModel: ReportViewModel
    @State var isShowMakeReport: Bool
    
    
    // MARK: -Init
    
    init(isShowMakeReport: Bool = false) {
        self._viewModel = StateObject(wrappedValue: ReportViewModel())
        self.isShowMakeReport = isShowMakeReport
    }
    
    
    var body: some View {
        NavigationStack {
            allGroup
        }
        .sheet(isPresented: $isShowMakeReport, content: {
                    SelectedBookListView()
                })
        .onAppear {
            viewModel.getReportData()
        }
    }
    
    // MARK: - ReportView Group
    private var allGroup: some View {
        VStack(alignment: .center, spacing: 46, content: {
            topCustomNavigation
            reportList
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea(.all)
        .background(Color.backgrounYellow)
    }
    
    /// 상단 탑 네비게이션
    private var topCustomNavigation: some View {
        CustomNavigation(title: "독후감", rightPlus: Image(systemName: "plus"), action: {
            isShowMakeReport = true
        })
    }
    
    @ViewBuilder
    /// 독후감 데이터의 유무에 따라 보이는 뷰
    private var reportList: some View {
        if viewModel.reportData?.result.bookReportResponses.isEmpty ?? true {
            notReportData
        } else {
            reportCardMake
        }
    }
    
    /// 등록된 독후감 데이터 있을 시, 독후감 카드 컴포넌트 새엉
    private var reportCardMake: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 0, maximum: 142))], alignment: .center, spacing: 16, pinnedViews: [], content: {
                ForEach(viewModel.reportData?.result.bookReportResponses ?? [], id: \.self) { report in
                    ReportCardView(reportData: report)
                }
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgrounYellow)
        .refreshable {
            viewModel.getReportData()
        }
    }
    
    /// 등록된 독후감 데이터 없을 시, 알려주는 뷰
    private var notReportData: some View {
        VStack(alignment: .center, spacing: 15, content: {
            
            Spacer().frame(maxHeight: 200)
            
            Icon.sadSpud.image
                .resizable()
                .frame(maxWidth: 126, maxHeight: 140)
                .aspectRatio(contentMode: .fit)
            Text("등록된 독후감이 없습니다.")
                .font(.spoqaHans(type: .bold, size: 18))
                .foregroundStyle(Color.gray06)
            
            
            Spacer()
        })
    }
}

struct Report_PrewView: PreviewProvider {
    
    static let devices = ["iPhone 11", "iPhone 15 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) {device in
            ReportView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
