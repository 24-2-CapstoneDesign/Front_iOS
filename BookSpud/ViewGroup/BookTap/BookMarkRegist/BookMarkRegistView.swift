//
//  BookMarkRegistView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import SwiftUI

struct BookMarkRegistView: View {
    
    
    @StateObject var viewModel: BookMarkResgistViewModel
    
    @Binding var isShowBookMarkRegist: Bool

    
    var body: some View {
        VStack(alignment: .center, spacing: 20, content: {
            Group {
                topTitleView
                selectedPage
                selectedVerses
                writedMeomo
                bookMarkRegistButton
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgrounYellow)
        .onAppear(perform: {
            UIApplication.shared.hideKeyboard()
        })
        .sheet(isPresented: $viewModel.isShowOCR, content: {
            OCRView(viewModel: viewModel, isShowOCR: $viewModel.isShowOCR)
        })
    }
    
    // MARK: - TopView
    
    private var topTitleView: some View {
        VStack(alignment: .center, spacing: 13, content: {
            BookMarkTitleView(emotion: viewModel.isSelectedEmotion)
            emotionMenu
        })
    }
    
    private var emotionMenu: some View {
        HStack(alignment: .center, spacing: 10, content: {
            SeletedEmotionBtn(title: "기쁨", currentStatus: .happy, selected: $viewModel.isSelectedEmotion, action: {
                viewModel.isSelectedEmotion = .happy
            })
            
            SeletedEmotionBtn(title: "슬픔", currentStatus: .sad, selected: $viewModel.isSelectedEmotion, action: {
                viewModel.isSelectedEmotion = .sad
            })
            
            SeletedEmotionBtn(title: "분노", currentStatus: .angry, selected: $viewModel.isSelectedEmotion, action: {
                viewModel.isSelectedEmotion = .angry
            })
            
            SeletedEmotionBtn(title: "영감", currentStatus: .inspiration, selected: $viewModel.isSelectedEmotion, action: {
                viewModel.isSelectedEmotion = .inspiration
            })
            
            SeletedEmotionBtn(title: "감동", currentStatus: .move, selected: $viewModel.isSelectedEmotion, action: {
                viewModel.isSelectedEmotion = .move
            })
        })
    }
    
    // MARK: - VersesView
    
    private var selectedPage: some View {
        HStack(alignment: .center, content: {
            Text("기록 페이지 💬")
                .font(.spoqaHans(type: .bold, size: 16))
                .kerning(-0.2)
                .foregroundStyle(Color.gray07)
            
            Spacer()
            
            
            ZStack(alignment: .center, content: {
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .frame(maxWidth: 78, maxHeight: 22)
                    .clipShape(.rect(cornerRadius: 4))
                    .shadow03()
                
                HStack(alignment: .center, content: {
                    TextField("", text: $viewModel.savePage)
                        .keyboardType(.numberPad)
                        .frame(maxWidth: 28, maxHeight: 22)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 5)
                        .background(Color.clear)
                        .font(.spoqaHans(type: .regular, size: 12))
                        
                    
                    Text("쪽")
                        .font(.spoqaHans(type: .regular, size: 12))
                        .foregroundStyle(Color.gray07)
                })
            })
        })
        .frame(maxWidth: 339, maxHeight: 22)
    }
    
    private var selectedVerses: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("선택한 구절 💬")
                .font(.spoqaHans(type: .bold, size: 16))
                .kerning(-0.2)
                .foregroundStyle(Color.gray07)
            
            Button(action: {
                viewModel.isShowOCR = true
                viewModel.sentences.removeAll()
            }, label: {
                VersesBackground(versesText: viewModel.selectedText)
            })
        })
    }
    
    private var writedMeomo: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("기록하고 싶은 메모 📝")
                .font(.spoqaHans(type: .bold, size: 16))
                .kerning(-0.2)
                .foregroundStyle(Color.gray07)
            ZStack(alignment: .bottomTrailing, content: {
                MemoTextField(text: $viewModel.memoText, placeholder: "입력된 메모가 없습니다.", maxWidth: 340, maxHeight: 132)
                Text("(\(viewModel.memoText.count)/200)")
                    .font(.spoqaHans(type: .regular, size: 12))
                    .foregroundStyle(Color.gray06)
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
            })
            .frame(maxWidth: 340)
        })
        .frame(maxWidth: 340, maxHeight: 200)
    }
    
    private var bookMarkRegistButton: some View {
        Button(action: {
            viewModel.postBookMark()
            isShowBookMarkRegist = false
        }, label: {
            Text("북마크 등록하기")
                .frame(maxWidth: 160, maxHeight: 40)
                .font(.spoqaHans(type: .bold, size: 16))
                .foregroundStyle(Color.white)
                .kerning(-0.2)
                .background(Color.primary1)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundStyle(Color.clear)
                )
                
                .clipShape(.rect(cornerRadius: 50))
        })
    }
}
