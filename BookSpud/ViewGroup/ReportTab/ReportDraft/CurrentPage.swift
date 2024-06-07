//
//  CurrentPage.swift
//  BookSpud
//
//  Created by 정의찬 on 6/5/24.
//

import SwiftUI

struct CurrentPage: View {
    
    @StateObject var viewModel: ReportDraftViewModel
    @State var nextButton: Bool = true
    
    
    var body: some View {
        currentPageView
            .transition(.move(edge: .trailing))
            .animation(.easeInOut(duration: 0.7), value: viewModel.currentPageIndex)
    }
    
    // MARK: - CurrentPageView
    
    @ViewBuilder
    private var currentPageView: some View {
        switch viewModel.currentPageIndex {
        case 0:
            firstPage // 논점
        case 1:
            secondPage // 서론
        case 2:
            thirdPage // 본론
        case 3:
            fouthPage
        default:
            
            EmptyView()
        }
    }
    
    // MARK: - FirstPage
    
    private var argumentMenu: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text("논점 정리하기 📝")
                .font(.spoqaHans(type: .bold, size: 16))
                .foregroundStyle(Color.gray07)
            
            Spacer()
            
            argumentBtn(value: viewModel.draftData?.result.arguments[0] ?? "논점이 생성 되지 않았습니다.")
            argumentBtn(value: viewModel.draftData?.result.arguments[1] ?? "논점이 생성 되지 않았습니다.")
            argumentBtn(value: viewModel.draftData?.result.arguments[2] ?? "논점이 생성 되지 않았습니다.")
            argumentBtn(value: viewModel.draftData?.result.arguments[3] ?? "논점이 생성 되지 않았습니다.")
            argumentBtn(value: viewModel.draftData?.result.arguments[4] ?? "논점이 생성 되지 않았습니다.")
        })
        .frame(maxWidth: 340, maxHeight: 327)
    }
    
    private var bookInfo: some View {
        ZStack(alignment: .center, content: {
            RoundedRectangle(cornerRadius: 4)
                .fill(
                    Color.white
                )
                .frame(maxWidth: 266, maxHeight: 239)
                .shadow03()
            
            VStack(alignment: .center, spacing: 18, content: {
                bookCover
                bookName
            })
        })
        .onAppear {
            let urlString = viewModel.data?.cover ?? ""
            if let url = URL(string: urlString) {
                viewModel.loadImage(from: url)
            }
        }
    }
    
    @ViewBuilder
    private var bookCover: some View {
        if let image = viewModel.bookCover {
            image
                .resizable()
                .frame(maxWidth: 100, maxHeight: 150)
                .aspectRatio(contentMode: .fit)
                .shadow02()
        } else {
            ProgressView()
                .frame(width: 100, height: 150)
        }
    }
    
    private var bookName: some View {
        VStack(alignment: .center, spacing: 10, content: {
            Text(viewModel.data?.title ?? "")
                .font(.spoqaHans(type: .bold, size: 12))
                .foregroundStyle(Color.mainText)
            
            Text(viewModel.data?.author ?? "")
                .font(.spoqaHans(type: .bold, size: 10))
                .foregroundStyle(Color.subText)
        })
    }
    
    // MARK: - PageGroup
    private var firstPage: some View {
        VStack(alignment: .center, content: {
            bookInfo
            
            Spacer()
            
            argumentMenu
            
            Spacer()
            
            pageNextButton(name: "다음", action: {
                
                if let argument = viewModel.selectedArgument {
                    
                    viewModel.postArguments(id: viewModel.data?.myBookId ?? 0, argument: argument)
                    
                    if viewModel.checkZeroBtn {
                        viewModel.currentPageIndex += 1
                        print("page 0")
                    }
                }
            })
            
        })
        .frame(maxWidth: 340, maxHeight: 670)
        .ignoresSafeArea(.keyboard)
    }
    
    /// 서론 입력 페이지(first)
    private var secondPage: some View {
        VStack(alignment: .center, spacing: 47, content: {
            topQuestion("서론", questionValue: viewModel.answerData?.result.introQuestion ?? "서론 질문이 생성되지 않았습니다.")
            
            BookSpud.MainDotLine()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [2,3]))
                .frame(width: 340, height: 1)
                .foregroundStyle(Color.gray04)
            
            answer(text: $viewModel.firstAnswer)
            
            Spacer()
            
            pageNextButton(name: "다음", action: {
                if viewModel.checkFirstBtn {
                    viewModel.currentPageIndex += 1
                    print("서론 버튼")
                }
            })
        })
        .onAppear {
            viewModel.postArguments(id: viewModel.data?.myBookId ?? 0, argument: viewModel.selectedArgument ?? "")
            DispatchQueue.main.asyncAfter(deadline: .now()+1.8) {
                viewModel.getAnswer(id: viewModel.responseArguments?.result.id ?? 0)
            }
        }
        .frame(maxWidth: 340, maxHeight: 669)
        .ignoresSafeArea(.keyboard)
    }
    
    /// 본론 입력 페이지(third)
    private var thirdPage: some View {
        VStack(alignment: .center, spacing: 47, content: {
            topQuestion("본론", questionValue: viewModel.answerData?.result.bodyQuestion ?? "본론 질문이 생성되지 않았습니다.")
            
            BookSpud.MainDotLine()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [2,3]))
                .frame(width: 340, height: 1)
                .foregroundStyle(Color.gray04)
      
            answer(text: $viewModel.secondAnswer)
            
            Spacer()
            
            pageNextButton(name: "다음", action: {
                if viewModel.checkSecondBtn {
                    viewModel.currentPageIndex += 1
                    print("본론 버튼")
                }
            })
        })
        .frame(maxWidth: 340, maxHeight: 669)
        .ignoresSafeArea(.keyboard)
    }
    
    private var fouthPage: some View {
        VStack(alignment: .center, spacing: 47, content: {
            topQuestion("결론", questionValue: viewModel.answerData?.result.conclusionQuestion ?? "결론 질문이 생성되지 않았습니다.")
            
            BookSpud.MainDotLine()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [2,3]))
                .frame(width: 340, height: 1)
                .foregroundStyle(Color.gray04)
            
            answer(text: $viewModel.thirdAnswer)
            
            Spacer()
            
            pageNextButton(name: "독후감 초안 작성", action: {
                if viewModel.checkThirdBtn {
                    viewModel.makeDraft(id: viewModel.responseArguments?.result.id ?? 0)
                }
            })
        })
        .frame(maxWidth: 340, maxHeight: 669)
        .ignoresSafeArea(.keyboard)
    }
    
    
    // MARK: - Function
    
    private func argumentBtn(value: String) -> some View {
        Button(action: {
            viewModel.selectedArgument = value
            print("논점 버튼 \(value) 선택")
        }, label: {
            Text(value)
                .font(.spoqaHans(type: .regular, size: 12))
                .foregroundStyle(Color.gray05)
                .frame(maxWidth: 300, minHeight: 11, alignment: .leading)
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 4))
                
        })
        .frame(width: 340, height: 50)
        
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .inset(by: 1)
                .stroke(viewModel.selectedArgument == value ? Color.errorDark : Color.primary1, lineWidth: 2)
        )
        .background(Color.white)
    }
    
    private func question(question: String) -> some View {
        
        VStack(alignment: .leading, spacing: 2, content: {
            
            Text("Q.")
                .font(.spoqaHans(type: .bold, size: 24))
                .foregroundStyle(Color.black)
            
            Text(question)
                .font(.spoqaHans(type: .bold, size: 24))
                .foregroundStyle(Color.black)
        })
    }
    
    private func pageNextButton(name: String, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Text(name)
                .font(.spoqaHans(type: .bold, size: 16))
                .foregroundStyle(Color.white)
                .frame(maxWidth: 160, maxHeight: 36)
                .background(Color.primary1)
                .clipShape(.rect(cornerRadius: 25))
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(Color.clear)
                        .frame(maxWidth: 160, maxHeight: 36)
                )
        })
    }
    
    
    private func topQuestion(_ value: String, questionValue: String) -> some View {
        HStack(alignment: .center, content: {
            VStack(alignment: .leading, spacing: 39, content: {
                Text("\(value) 📝")
                    .font(.spoqaHans(type: .bold, size: 16))
                    .foregroundStyle(Color.gray07)
                    .kerning(-0.2)
                
                question(question: questionValue)
            })
            
            Spacer()
        })
    }
    
    
    private func answer(text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Text("A.")
                .font(.spoqaHans(type: .bold, size: 24))
                .foregroundStyle(Color.primary1)
                .padding(.leading, 8)
            
            MemoTextField(text: text,
                          placeholder: "답변을 입력해주세요",
                          maxWidth: 340, maxHeight: 120)
        })
        .padding(.leading, 8)
    }
}
