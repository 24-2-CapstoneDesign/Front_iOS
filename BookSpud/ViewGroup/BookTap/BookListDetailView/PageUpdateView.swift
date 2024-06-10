//
//  PageUpdateView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/6/24.
//

import SwiftUI

/// 저장한 책 내부 정보뷰, 페이지 업데이트 뷰
struct PageUpdateView: View {
    
    @ObservedObject var viewModel: BookDetailViewModel
    @Binding var showPageUpdateView: Bool
    
    // MARK: - Init
    
    init(viewModel: BookDetailViewModel, showPageUpdateView: Binding<Bool>) {
        self.viewModel = viewModel
        self._showPageUpdateView = showPageUpdateView
    }
    
    var body: some View {
        ZStack(alignment: .center, content: {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.successLight)
                .frame(maxWidth: 340, maxHeight: 300)
                .shadow03()
            
            VStack(alignment: .center, spacing: 35, content: {
                topTitle
                
                VStack(alignment: .center, spacing: 21, content: {
                    inputPageNumer(name: "전체 페이지", text: $viewModel.bookListDetailData.totalPage)
                    inputPageNumer(name: "현재 페이지", text: $viewModel.bookListDetailData.finalPage)
                })
                
                savePageCount
            })
        })
        .frame(maxWidth: 422, maxHeight: 300)
        .onAppear(perform: {
            UIApplication.shared.hideKeyboard()
        })
    }
    
    // MARK: - PageUpdateView
    
    private var topTitle: some View {
        HStack(alignment: .center, spacing: 13, content: {
            Icon.sensationSpud.image
                .resizable()
                .frame(maxWidth: 52, maxHeight: 49)
                .aspectRatio(contentMode: .fit)
            
            Text("페이지를 업데이트 해줘!!")
                .font(.spoqaHans(type: .medium, size: 21))
                .foregroundStyle(Color.gray07)
        })
    }
    
    
    
    private var savePageCount: some View {
        Button(action: {
            if viewModel.bookListDetailData.finalPage <= viewModel.bookListDetailData.totalPage {
                viewModel.patchPage(id: viewModel.bookListDetailData.myBookId, bookData: viewModel.bookListDetailData)
                showPageUpdateView = false
            }
        }, label: {
            Text("저장하기")
                .font(.spoqaHans(type: .bold, size: 16))
                .foregroundStyle(Color.white)
                .frame(maxWidth: 160, maxHeight: 36)
                .background(viewModel.bookListDetailData.finalPage <= viewModel.bookListDetailData.totalPage ?  Color.primary1 : Color.gray05)
                .clipShape(.rect(cornerRadius: 25))
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(Color.clear)
                        .frame(maxWidth: 160, maxHeight: 36)
                )
        })
    }
    
    private func inputPageNumer(name: String, text: Binding<Int>) -> some View {
        HStack(alignment: .center, content: {
            Text(name)
                .font(.pretendard(type: .semiBold, size: 14))
                .foregroundStyle(Color.black)
            CustomTextField(keyboardType: .numberPad, text: Binding(
                get: {String(text.wrappedValue)},
                set: {text.wrappedValue = Int($0) ?? text.wrappedValue}
            ), placeholder: "\(name) 입력 해주세요", showCheckIcon: false, maxWidth: 107, maxHeight: 41)
        })
        .frame(maxWidth: 212)
    }
}
