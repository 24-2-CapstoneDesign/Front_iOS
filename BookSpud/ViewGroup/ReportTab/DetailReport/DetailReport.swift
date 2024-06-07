//
//  DetailReport.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import SwiftUI

struct DetailReport: View {
    
    @StateObject var viewModel: ReportCardViewModel
    @StateObject var reportDraftViewModel: ReportDraftViewModel
    @State var firstText: String = ""
    @State var secondText: String = ""
    @State var thirdText: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView(.vertical) {
            bookInfo
        }
        .background(Color.backgrounYellow)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden()
        
    }
    
    private var topNavigation: some View {
        Rectangle()
            .fill(Color.primary1)
            .frame(maxWidth: 430, maxHeight: 60)
            .ignoresSafeArea(.all)
    }
    
    @ViewBuilder
    private var bookCover: some View {
        if let image = viewModel.bookCover {
            image
                .resizable()
                .frame(maxWidth: 100, maxHeight: 150)
                .aspectRatio(contentMode: .fit)
        } else {
            ProgressView()
                .frame(width: 100, height: 150)
        }
    }
    
    private var bookInfo: some View {
        VStack(alignment: .center,spacing: 13, content: {
            CustomNavigation(title: "독후감")
            
            Spacer()
            
            bookCover
            VStack(alignment: .center, spacing: 16, content: {
                Text(viewModel.bookReportResponse.title)
                    .font(.spoqaHans(type: .bold, size: 16))
                    .foregroundStyle(Color.mainText)
                    .frame(minWidth: 232)
                
            
                
                Text("논점: \(viewModel.bookReportResponse.argument)")
                    .font(.spoqaHans(type: .medium, size: 14))
                    .foregroundStyle(Color.mainText)
                    .frame(minWidth: 232)
            })
            Text(viewModel.bookReportResponse.status)
                .font(.spoqaHans(type: .bold, size: 12))
                .foregroundStyle(Color.white)
                .frame(maxWidth: 50, maxHeight: 21)
                .padding()
                .background(Color.errorDefault)
                .clipShape(.rect(cornerRadius: 50))
                .padding(.all, 5)

            ReadWriteText(title: "서론", verses: reportDraftViewModel.detailBookReport?.result.intro ?? "서론이 생성되지 못했습니다.", place: reportDraftViewModel.detailBookReport?.result.introEmotion ?? "", emotionMemo: $firstText)
            ReadWriteText(title: "본론", verses: reportDraftViewModel.detailBookReport?.result.body ?? "본론이 생성되지 못했습니다.", place: reportDraftViewModel.detailBookReport?.result.bodyEmotion ?? "", emotionMemo: $secondText)
            ReadWriteText(title: "결론", verses: reportDraftViewModel.detailBookReport?.result.conclusion ?? "결론이 생성되지 못했습니다.", place: reportDraftViewModel.detailBookReport?.result.conclusionEmotion ?? "", emotionMemo: $thirdText)
            
                Button(action: {
                    viewModel.patchEmotion(id: viewModel.bookReportResponse.bookReportId)
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
            
            Spacer()
        })
        .frame(maxWidth: .infinity, minHeight: 1800, maxHeight: 2000)
        .onAppear {
            reportDraftViewModel.showDetailBookReport(id: viewModel.bookReportResponse.bookReportId)
            
        let url = viewModel.bookReportResponse.cover
           if let UrlString = URL(string: url) {
                viewModel.loadImage(from: UrlString)
            }
        }
    }
    
}
