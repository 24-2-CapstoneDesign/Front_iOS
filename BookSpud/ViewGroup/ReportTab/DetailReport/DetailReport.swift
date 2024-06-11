//
//  DetailReport.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import SwiftUI
import Kingfisher

/// 독후감 상세 보기 뷰
struct DetailReport: View {
    
    @StateObject var viewModel: DetailReportViewModel
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Init
    
    init(bookData: BookReportResponse) {
        self._viewModel = StateObject(wrappedValue: DetailReportViewModel(bookData: bookData))
    }
    
    var body: some View {
        ScrollView(.vertical) {
            bookInfo
        }
        .background(Color.backgrounYellow)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden()
        
    }
    
    private var bookInfo: some View {
        VStack(alignment: .center,spacing: 13, content: {
            
            bookCover
            
            Spacer()
        })
        .frame(maxWidth: .infinity, minHeight: 1800, maxHeight: 2000)
    }
    
    /// 상단 탑 네비게이션
    private var topNavigation: some View {
        Rectangle()
            .fill(Color.primary1)
            .frame(maxWidth: 430, maxHeight: 60)
            .ignoresSafeArea(.all)
    }
    
    private var customTopNavigation: some View {
        CustomNavigation(title: "독후감")
    }
    
    @ViewBuilder
    /// 책 표지
    private var bookCover: some View {
        if let url = URL(string: viewModel.bookData.cover) {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .frame(width: 100, height: 150)
                } .retry(maxCount: 2, interval: .seconds(2))
                .resizable()
                .frame(maxWidth: 100, maxHeight: 150)
                .aspectRatio(contentMode: .fit)
        } else {
            ProgressView()
                .frame(width: 100, height: 150)
        }
    }
    
    /// 책 제목과 논점
    private var bookTitleArgu: some View {
        VStack(alignment: .center, spacing: 16, content: {
            Text(viewModel.bookData.title)
                .font(.spoqaHans(type: .bold, size: 16))
                .foregroundStyle(Color.mainText)
                .frame(minWidth: 232)
            
            Text("논점: \(viewModel.bookData.argument)")
                .font(.spoqaHans(type: .medium, size: 14))
                .foregroundStyle(Color.mainText)
                .frame(minWidth: 232)
            
            ReportTagComponent(name: viewModel.bookData.status)
        })
    }
    
    /// 서론 본론 결론 작성
    private var bookOrganization: some View {
        VStack(alignment: .center, spacing: 45, content: {
            
            if let data = viewModel.detailBookReport?.result {
                ReadWriteText(title: "서론", verses: data.intro,
                              place: viewModel.getQuestionRandom(),
                              icon: Icon.happySpud.image,
                              emotionMemo: $viewModel.introEmotionText)
                
                BookSpud.MainDotLine()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [2,3]))
                    .frame(width: 340, height: 1)
                    .foregroundStyle(Color.gray04)
                
                
                ReadWriteText(title: "본론", verses: data.body,
                              place: viewModel.getQuestionRandom(),
                              icon: Icon.inspirationSpud.image,
                              emotionMemo: $viewModel.bodyEmotionText)
                
                BookSpud.MainDotLine()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [2,3]))
                    .frame(width: 340, height: 1)
                    .foregroundStyle(Color.gray04)
                
                ReadWriteText(title: "결론", verses: data.conclusion,
                              place: viewModel.getQuestionRandom(),
                              icon: Icon.moveEmotion.image,
                              emotionMemo: $viewModel.conclustionText)
            }
        })
    }
    
    /// 초안 작성 완료 버튼
    private var sendFinalReport: some View {
        Button(action: {
            viewModel.makeFinalReport(argumentId: viewModel.bookData.bookReportId)
        }, label: {
            Text("초안 작성 완료")
                .font(.spoqaHans(type: .bold, size: 15))
                .foregroundStyle(Color.white)
                .padding()
                .frame(maxWidth: 160, maxHeight: 36)
                .background(Color.primary1)
                .clipShape(.rect(cornerRadius: 50))
                .padding(.all, 20)
        })
    }
}
