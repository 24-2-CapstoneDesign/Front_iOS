//
//  ReportCardView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/5/24.
//

import SwiftUI
import Kingfisher

struct ReportCardView: View {
    
    let reportData: BookReportResponse
    
    // MARK: - Init
    
    init(reportData: BookReportResponse) {
        self.reportData = reportData
    }
    
    var body: some View {
        allGroup
    }
    
    // MARK: - ReportCardView
    
    private var allGroup: some View {
        
        
        ZStack(alignment: .bottom, content: {
            
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white)
                .frame(width: 380, height: 142)
                .shadow03()
            
            HStack(alignment: .center, spacing: 19, content: {
                bookCoverView
                rightBookInfo
            })
            .frame(maxWidth: 322, maxHeight: 142, alignment: .top)
            .clipped()
        })
        .frame(width: 380, height: 142)
        
    }
    
    @ViewBuilder
    private var bookCoverView: some View {
        if let url = URL(string: reportData.cover) {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .frame(width: 150, height: 224)
                } .retry(maxCount: 2, interval: .seconds(2))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 150, maxHeight: 224)
                .shadow03()
                .padding(.top, 20)
        }
    }
    
    private var rightBookInfo: some View {
        VStack(alignment: .leading, spacing: 1, content: {
            ReportTagComponent(name: reportData.status)
            
            VStack(alignment: .leading, spacing: 0, content: {
                Text(reportData.title)
                    .font(.spoqaHans(type: .bold, size: 16))
                    .foregroundStyle(Color.black)
                
                    .padding(.top, 5)
                
                Text("논점 : \(reportData.argument)")
                    .font(.spoqaHans(type: .regular, size: 12))
                    .foregroundStyle(Color.gray05)
                    .multilineTextAlignment(.trailing)
            })
            .frame(minWidth: 153, minHeight: 61, alignment: .topLeading)
            
          
            Text(reportData.updatedAt)
                .font(.spoqaHans(type: .regular, size: 12))
                .foregroundStyle(Color.gray05)
                .kerning(-0.2)
            
            Spacer()
        })
        .frame(maxWidth: 153, minHeight: 190)
    }
}
