//
//  OCRView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/4/24.
//

import SwiftUI

struct OCRView: View {
    @ObservedObject var viewModel: BookMarkRegistViewModel
    @Binding var isShowOCR: Bool
    
    
    init(viewModel: BookMarkRegistViewModel, isShowOCR: Binding<Bool>) {
        self.viewModel = viewModel
        self._isShowOCR = isShowOCR
    }

    var body: some View {
        VStack(alignment: .center, spacing: 23) {
            if !viewModel.sentences.isEmpty {
                ScrollView {
                    ForEach(viewModel.sentences, id: \.self) { sentence in
                        Button(action: {
                            viewModel.selectedText = sentence
                            isShowOCR = false
                        }) {
                            Text(sentence)
                                .frame(minHeight: 30, maxHeight: 100)
                                .font(.gangwonEdu(type: .basic, size: 20))
                                .padding()
                                .foregroundStyle(Color.gray07)
                                .background(Color.white)
                                .clipShape(.rect(cornerRadius: 4))
                                .shadow03()
                                .padding(.horizontal, 10)
                                
                        }
                        .padding(.vertical, 10)
                    }
                }
                .padding()
            } else {
                Text("카메라를 열어 텍스트를 스캔하세요.")
                    .font(.spoqaHans(type: .bold, size: 16))
                    .foregroundStyle(Color.black)
                    .padding()
            }

            Button(action: {
                self.viewModel.isCamera = true
            }) {
                Text("카메라 열기")
                    .frame(maxWidth: 160, maxHeight: 36)
                    .font(.spoqaHans(type: .bold, size: 16))
                    .foregroundStyle(Color.white)
                    .clipShape(.rect(cornerRadius: 50))
                    .background(Color.primaryDark)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.clear)
                    )
                    .clipShape(.rect(cornerRadius: 50))
                    
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgrounYellow)
        .sheet(isPresented: $viewModel.isCamera) {
            CameraView(recognizedText: $viewModel.recognizedText)
        }
    }
}
