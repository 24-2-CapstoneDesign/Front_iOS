//
//  DetailReportB.swift
//  BookSpud
//
//  Created by 정의찬 on 6/12/24.
//

import SwiftUI
import Kingfisher

/// 최종 독후감
struct DetailReportB: View {
    
    @StateObject var viewModel: DetailReportViewModel
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Init
    
    init(bookData: BookReportResponse) {
        self._viewModel = StateObject(wrappedValue: DetailReportViewModel(bookData: bookData))
    }
    
    var body: some View {
        VStack(spacing: 15) {
            customTopNavigation
            bookInfo
        }
        .background(Color.backgrounYellow)
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
    
    private var bookInfo: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center,spacing: 13, content: {
                bookTitleArgu
                bookOrganization
                
                Spacer().frame(height: 20)
            })
            .frame(maxWidth: .infinity, minHeight: 1850, alignment: .top).ignoresSafeArea(.keyboard)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.showDetailBookReport(argumentId: viewModel.bookData.bookReportId)
        }
        .onAppear(perform: {
            UIApplication.shared.hideKeyboard()
        })
        .scrollDismissesKeyboard(.immediately)
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
            
            bookCover
            
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
        VStack(alignment: .center, spacing: 35, content: {
            
            if viewModel.isLoading {
                ProgressView("데이터 로딩 중입니다..")
                    .progressViewStyle(CircularProgressViewStyle())
                
                Spacer()
            } else {
                if let data = viewModel.detailBookReport?.result {
                    ReadWriteText(title: "서론", verses: data.intro,
                                  place: "",
                                  icon: Icon.happySpud.image,
                                  changeOn: false,
                                  emotionMemo: $viewModel.introEmotionText)
                    
                    BookSpud.MainDotLine()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [2,3]))
                        .frame(width: 340, height: 1)
                        .foregroundStyle(Color.gray04)
                    
                    
                    ReadWriteText(title: "본론", verses: data.body,
                                  place: "",
                                  icon: Icon.inspirationSpud.image,
                                  changeOn: false,
                                  emotionMemo: $viewModel.bodyEmotionText)
                    
                    BookSpud.MainDotLine()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [2,3]))
                        .frame(width: 340, height: 1)
                        .foregroundStyle(Color.gray04)
                    
                    ReadWriteText(title: "결론", verses: data.conclusion,
                                  place: "",
                                  icon: Icon.sensationSpud.image,
                                  changeOn: false,
                                  emotionMemo: $viewModel.conclustionEmotionText)
                }
            }
        })
    }
}

