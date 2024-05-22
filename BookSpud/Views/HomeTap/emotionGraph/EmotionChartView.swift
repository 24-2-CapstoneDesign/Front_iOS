//
//  EmotionChart.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import SwiftUI
import Charts

struct EmotionChartView: View {
    
    @StateObject var emotionChartViewModel: EmotionChartViewModel
    
    var body: some View {
        allViewGroup
    }
    
    
    // MARK: - Property
    /// Vstack내부 뷰 그룹
    private var allViewGroup: some View {
        VStack(alignment: .center, spacing: 29, content: {
            
            chartTitle
            chartPieGrahp
            charStickGraph
            
        })
        .frame(width: 334, height: 500)
        .onAppear {
            emotionChartViewModel.onApearData()
        }
        .background(
            Rectangle()
                .foregroundStyle(Color.white)
                .clipShape(.rect(cornerRadius: 4))
                .shadow02()
        )
        
    }
    
    /// 차트 타이틀
    private var chartTitle: some View {
        VStack(alignment: .center, spacing: 8, content: {
            Text(emotionChartViewModel.currentDate ?? "")
                .frame(minWidth: 80)
                .font(.spoqaHans(type: .bold, size: 12))
                .foregroundStyle(Color.gray05)
                .kerning(-0.2)
            
            Text("\(emotionChartViewModel.userName)의 감정 그래프 📊")
                .frame(minWidth: 163)
                .font(.spoqaHans(type: .bold, size: 18))
                .foregroundStyle(Color.black)
        })
    }
    
    /// 가운데 파이 그래프
    private var chartPieGrahp: some View {
        Chart(emotionChartViewModel.emotions) { emotion in
            SectorMark(
                angle: .value("Value", emotion.value),
                innerRadius: .ratio(0.6),
                angularInset: 1
            )
            .cornerRadius(3)
            .foregroundStyle(emotion.color)
        }
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                if let anchor = chartProxy.plotFrame {
                    let frame = geometry[anchor]
                    VStack {
                        Text("당신의 감정")
                            .font(.spoqaHans(type: .bold, size: 12))
                            .foregroundStyle(Color.gray05)
                            .kerning(-0.2)
                        Image(emotionChartViewModel.dominationEmotion.name)
                            .resizable()
                            .frame(maxWidth: 59, maxHeight: 33)
                            .aspectRatio(contentMode: .fit)
                    }
                    .position(x: frame.midX, y: frame.midY)
                }
            }
        }
        .frame(width: 200, height: 200)
    }
    
    private var charStickGraph: some View {
        VStack(alignment: .center, spacing: 12, content: {
            ForEach(emotionChartViewModel.emotions) { emotion in
                HStack(alignment: .center, spacing: 5, content: {
                    
                    Text(emotionChartViewModel.stickGraphName(emotion.name))
                        .font(.spoqaHans(type: .bold, size: 12))
                        .kerning(-0.2)
                        .foregroundStyle(.gray05)
                    
                    ProgressView(value: Double(emotion.value), total: 100)
                        .progressViewStyle(.linear)
                        .tint(emotion.color)
                        .frame(maxWidth: 200, maxHeight: 15)
                        .scaleEffect(x: 1.0, y: 4.0, anchor: .center)
                        .clipShape(.rect(cornerRadius: 15))
                    
                    Text(String(emotion.value))
                        .font(.spoqaHans(type: .bold, size: 12))
                        .foregroundStyle(.gray05)
                    
                })
            }
        })
    }
}

struct EmotionChartView_Preview: PreviewProvider {
    static var previews: some View {
        EmotionChartView(emotionChartViewModel: EmotionChartViewModel())
            .previewLayout(.sizeThatFits)
    }
}
