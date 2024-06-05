//
//  OCRView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/4/24.
//

import SwiftUI

import SwiftUI

struct OCRView: View {
    @ObservedObject var viewModel: BookMarkResgistViewModel

    var body: some View {
        VStack {
            if !viewModel.versesText.isEmpty {
                ScrollView {
                    Text(viewModel.versesText)
                        .padding()
                        .onTapGesture {
                            // 텍스트 클릭 시의 동작을 정의합니다.
                        }
                }
            } else {
                Text("카메라를 열어 텍스트를 스캔하세요.")
                    .padding()
            }

            Button(action: {
                self.viewModel.isShowOCR = true
            }) {
                Text("카메라 열기")
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.isShowOCR) {
            CameraView(recognizedText: $viewModel.versesText)
        }
    }
}
