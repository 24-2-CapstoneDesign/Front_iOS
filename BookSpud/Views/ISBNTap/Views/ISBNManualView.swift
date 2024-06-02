//
//  ISBNView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/11/24.
//

import SwiftUI

struct ISBNManualView: View {
    
    @ObservedObject var viewModel: ISBNInputViewModel
    
    var body: some View {
        VStack(alignment: .center, content: {
            
            Spacer().frame(maxHeight: 120)
            
            topComponents
            
            Spacer().frame(maxHeight: 309)
            
            GlobalMainBtn(clickBool: $viewModel.isbnTextClicked,
                          btnName: "등록하기",
                          btnImg: Icon.resgistISBN,
                          onClicked: {
                viewModel.registBtn()
            })
        })
        .sheet(isPresented: $viewModel.isShowSaveView, content: {
            SuccessISBN(viewModel: viewModel)
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.visible)
        })
        .frame(maxWidth: 343)
    }
    
    private var topComponents: some View {
        VStack(alignment: .center, spacing: 37, content: {
            Text("ISBN 번호를 입력해주세요!")
                .font(.spoqaHans(type: .bold, size: 24))
                .kerning(-0.2)
                .foregroundStyle(Color.black)
            
            CustomTextField(text: $viewModel.isbnText,
                            placeholder: "ISBN 번호를 입력해주세요",
                            showCheckIcon: false,
                            maxWidth: 297,
                            maxHeight: 47)
        })
    }
}

struct ISBNManualView_Preview:  PreviewProvider {
    static var previews: some View {
        ISBNManualView(viewModel: ISBNInputViewModel())
    }
}
