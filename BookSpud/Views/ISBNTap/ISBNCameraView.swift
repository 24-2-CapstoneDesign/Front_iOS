//
//  ISBNCameraView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/30/24.
//

import SwiftUI

struct ISBNCameraView: View {
    
    @ObservedObject var viewModel = ISBNInputViewModel()
    @State var clickManual: Bool = true
    
    var body: some View {
        overlayView
    }
    
    // MARK: - Barcode Scan OverlayView
    
    private var overlayView: some View {
        ZStack(alignment: .center, content: {
            background
            VStack(alignment: .center, content: {
                
                Spacer()
                
                title
                
                Spacer().frame(maxHeight: 453)
                
                cameraBtn
            })
            .frame(maxWidth: 415, maxHeight: 627)
        })
    }
    
    private var title: some View {
        VStack(alignment: .center, spacing: 10, content: {
            Text("바코드를 스캔해주세요!")
                .font(.spoqaHans(type: .bold, size: 24))
                .kerning(-0.2)
                .foregroundStyle(Color.white)
            
            Text("ISBN 바코드 스캔을 통해\n 책의 정보를 빠르고 정확하게 가져올 수 있어요!")
                .font(.spoqaHans(type: .regular, size: 12))
                .kerning(-0.2)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
        })
    }
    
    private var background: some View {
        Icon.scanGuide.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(.all)
    }
    
    private var cameraBtn: some View {
        GlobalMainBtn(clickBool: $clickManual, btnName: "코드 직접 입력하기", btnImg: Icon.manualCode, onClicked: {
            viewModel.showManualView = true
        })
    }
    
}

struct ISBNCameraView_Preview: PreviewProvider {
    
    static let devices = ["iPhone 11", "iPhone 15 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            ISBNCameraView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
        
    }
}
