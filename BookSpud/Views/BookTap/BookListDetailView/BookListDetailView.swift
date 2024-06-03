//
//  BookListDetailView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import SwiftUI

struct BookListDetailView: View {
    
    @StateObject var viewModel: BookDetailViewModel
    @State var isShowBoookMark: Bool = false
    @State var isShowCountEdit: Bool = false
    @State var isSelected: BookEmotionKind = .happy
    
    let data = BookMarkList.data
    
    var body: some View {
        VStack(spacing: 20, content: {
            
            topBookView
            
            BookSpud.MainDotLine()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [2, 3]))
                .frame(width: 390, height: 1)
                .foregroundStyle(Color.gray04)
            
            bottomBookMarkView
        })
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - Top BookInfo
    
    private var topBookView: some View {
        ZStack(alignment: .top, content: {
            backgroundView
            VStack(alignment: .center, spacing: 10, content: {
                Spacer()
                Group {
                    topNavigation
                    bookInfo
                    bookInfoCount
                    btnGroup
                }
            })
            .padding(.top, 35)
            .frame(alignment: .bottom)
        })
        .frame(maxWidth: .infinity).ignoresSafeArea(.all)
    }
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(
                Color.backgrounYellow
            )
            .frame(maxWidth: 429, maxHeight: 340)
    }
    
    
    private var topNavigation: some View {
        CustomNavigation(title: "책 정보", onOff: false, height: 40)
    }
    
    /// 상단 책 정보
    private var bookInfo: some View {
        VStack(alignment: .center, spacing: 10, content: {
            if let image = viewModel.bookCoverImage {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 100, minHeight: 150)
            } else {
                ProgressView()
            }
            
            Text(viewModel.bookListDetailData.bookName)
                .font(.spoqaHans(type: .bold, size: 12))
                .foregroundStyle(Color.mainText)
                .frame(maxWidth: 246, maxHeight: 9)
                .kerning(-0.2)
            
            Text(viewModel.bookListDetailData.bookAuthor)
                .font(.spoqaHans(type: .regular, size: 10))
                .foregroundStyle(.subText)
                .kerning(-0.2)
        })
        .onAppear {
            viewModel.loadImage()
        }
    }
    
    private var bookInfoCount: some View {
        ZStack(alignment: .center, content: {
            RoundedRectangle(cornerRadius: 4)
                .fill(
                    Color.white
                )
                .frame(maxWidth: 369, maxHeight: 91)
                .shadow03()
            
            HStack(alignment: .center, spacing: 53, content: {
                BookCountView(count: viewModel.bookListDetailData.bookTotalPage,
                              title: "총 페이지")
                BookCountView(count: viewModel.bookListDetailData.bookCurrentPage,
                              title: "읽은 페이지")
                BookCountView(count: viewModel.bookListDetailData.bookMarkCount,
                              title: "북마크 수")
            })
        })
    }
    
    private var btnGroup: some View {
        HStack(alignment: .center, spacing: 10, content: {
            makeBtn(title: "북마크 생성하기", action: {
                self.isShowBoookMark = false
            }, color: Color.primaryDark)
            
            makeBtn(title: "페이지 업데이트", action: {
                self.isShowCountEdit = true
            }, color: Color.primary1)
        })
        .padding(.vertical, 10)
    }
    // MARK: - Bottom BookMarkView
    
    private var bottomBookMarkView: some View {
        VStack(alignment: .center, spacing: 5, content: {
            emotionBtnList
            bookMarkList
        })
        
    }
    
    private var emotionBtnList: some View {
        HStack(spacing: 10, content: {
            SeletedEmotionBtn(title: "기쁨", currentStatus: .happy, selected: $isSelected, action: {
                withAnimation {
                    isSelected = .happy
                }
                
            })
            SeletedEmotionBtn(title: "슬픔", currentStatus: .sad, selected: $isSelected, action: {
                withAnimation {
                    isSelected = .sad
                }
            })
            SeletedEmotionBtn(title: "분노", currentStatus: .angry, selected: $isSelected, action: {
                withAnimation {
                    isSelected = .angry
                }
            })
            SeletedEmotionBtn(title: "영감", currentStatus: .inspiration, selected: $isSelected, action: {
                withAnimation {
                    isSelected = .inspiration
                }
            })
            SeletedEmotionBtn(title: "감동", currentStatus: .move, selected: $isSelected, action: {
                withAnimation {
                    isSelected = .move
                }
            })
        })
    }
    
    private var bookMarkList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 0, maximum: 64), spacing: 15), count: 4), spacing: 15, content: {
                ForEach(filteredMark(), id: \.self) { information in
                    Icon.icon(for: information.emotion).image
                        .fixedSize()
                        .padding([.vertical, .horizontal], 5)
                }
            })
            .padding(.vertical, 15)
        }
        .frame(maxWidth: .infinity, maxHeight: 380)
    }
    
    
    // MARK: - Function
    
    private func filteredMark() -> [BookMarkDetailData] {
        switch isSelected {
        case .happy:
            return data.information.filter { $0.emotion == "happy" }
        case .sad:
            return data.information.filter { $0.emotion == "sad" }
        case .angry:
            return data.information.filter { $0.emotion == "angry" }
        case .inspiration:
            return data.information.filter { $0.emotion == "inspiration" }
        case .move:
            return data.information.filter { $0.emotion == "move" }
        }
    }
    
    private func makeBtn(title: String, action: @escaping () -> Void, color: Color) -> some View{
        Button(action: {
            action()
        }, label: {
            Text(title)
                .frame(maxWidth: 160, maxHeight: 40)
                .font(.spoqaHans(type: .bold, size: 16))
                .foregroundStyle(Color.white)
                .kerning(-0.2)
                .background(color)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundStyle(Color.clear)
                )
                
                .clipShape(.rect(cornerRadius: 50))
        })
    }
    
    
}

struct BookListDetailView_Preview: PreviewProvider {
    static let devices = ["iPhone 11", "iPhone 15 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            BookListDetailView(viewModel: BookDetailViewModel(bookListDetailData: BookListDetailData(bookCover: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788954695053.jpg", bookName: "아주 희미안 빛으로도", bookAuthor: "최은영", bookCurrentPage: 324, bookTotalPage: 324, bookMarkCount: 34)))
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}


// MARK: - Enum

enum BookEmotionKind: String {
    case happy = "기쁨"
    case sad = "슬픔"
    case angry = "분노"
    case inspiration = "영감"
    case move = "감동"
}
