//
//  BookMarkRegistView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import SwiftUI

struct BookMarkRegistView: View {
    
    @State var isSelectedEmotion: BookEmotionKind = .happy
    @StateObject var viewModel = BookMarkResgistViewModel()
    
    @Binding var isShowBookMarkRegist: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 20, content: {
            Group {
                topTitleView
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
            OCRView(viewModel: viewModel)

        })
    }
    
    // MARK: - TopView
    
    private var topTitleView: some View {
        VStack(alignment: .center, spacing: 13, content: {
            BookMarkTitleView(emotion: isSelectedEmotion)
            emotionMenu
        })
    }
    
    private var emotionMenu: some View {
        HStack(alignment: .center, spacing: 10, content: {
            SeletedEmotionBtn(title: "기쁨", currentStatus: .happy, selected: $isSelectedEmotion, action: {
                self.isSelectedEmotion = .happy
            })
            
            SeletedEmotionBtn(title: "슬픔", currentStatus: .sad, selected: $isSelectedEmotion, action: {
                self.isSelectedEmotion = .sad
            })
            
            SeletedEmotionBtn(title: "분노", currentStatus: .angry, selected: $isSelectedEmotion, action: {
                self.isSelectedEmotion = .angry
            })
            
            SeletedEmotionBtn(title: "영감", currentStatus: .inspiration, selected: $isSelectedEmotion, action: {
                self.isSelectedEmotion = .inspiration
            })
            
            SeletedEmotionBtn(title: "감동", currentStatus: .move, selected: $isSelectedEmotion, action: {
                self.isSelectedEmotion = .move
            })
        })
    }
    
    // MARK: - VersesView
    
    private var selectedVerses: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("선택한 구절 💬")
                .font(.spoqaHans(type: .bold, size: 16))
                .kerning(-0.2)
                .foregroundStyle(Color.gray07)
            
            Button(action: {
                viewModel.isShowOCR = true
            }, label: {
                VersesBackground(versesText: viewModel.versesText)
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
        })
        .frame(maxWidth: 340, maxHeight: 200)
    }
    
    private var bookMarkRegistButton: some View {
        Button(action: {
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


struct BookMarkRegistView_Preview: PreviewProvider {
    
    @State static var isShow: Bool = false
    
    static var previews: some View {
        BookMarkRegistView(isShowBookMarkRegist: $isShow)
    }
}
