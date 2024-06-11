//
//  BookListDetailView.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import SwiftUI
import Kingfisher

/// 저장된 책 상세 정보 조회 뷰
struct BookListDetailView: View {
    
    @StateObject var viewModel: BookDetailViewModel
    /* 북마크 생성하기 버튼 */
    @State var isShowBoookMarkMake: Bool = false
    /* 책 페이지 수정 */
    @State var isShowCountEdit: Bool = false
    /* 북마크 정보 Sheet */
    @State var isShowBookMarkInfo: Bool = false
    /* 북마크 감정 교체 버튼 */
    @State var isSelected: BookEmotionKind = .happy
    @State var selectedBookMark: BookMarkDetailData?
    
    
    init(bookData: BookListDetailData) {
        self._viewModel = StateObject(wrappedValue: BookDetailViewModel(bookListDetailData: bookData))
    }
    
    
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
        
        .sheet(isPresented: $isShowBoookMarkMake, content: {
            BookMarkRegistView(bookId: viewModel.bookListDetailData.myBookId, isShowBookMarkRegist: $isShowBoookMarkMake)
                .presentationDetents([.fraction(0.8)])
                .presentationDragIndicator(.visible)
                .onDisappear {
                    viewModel.getBookMark(id: viewModel.bookListDetailData.myBookId)
                }
        })
        
        .fullScreenCover(isPresented: $isShowCountEdit, content: {
            PageUpdateView(viewModel: viewModel, showPageUpdateView: $isShowCountEdit)
                .presentationBackground(Color.clear)
        })
        
        .onAppear {
            viewModel.getBookMark(id: viewModel.bookListDetailData.myBookId)
        }
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
            .padding(.top, 30)
            .frame(alignment: .bottom)
        })
        .frame(maxWidth: .infinity).ignoresSafeArea(.all)
    }
    
    /// 책 정보를 담고 있는 배경화면
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(
                Color.backgrounYellow
            )
            .frame(maxWidth: 429, maxHeight: 340)
    }
    
    
    /// 이전으로 돌아가는 커스텀 네비게이션
    private var topNavigation: some View {
        CustomNavigation(title: "책 정보", onOff: false, height: 35, padding: -5)
    }
    
    /// 상단 책 정보
    private var bookInfo: some View {
        VStack(alignment: .center, spacing: 10, content: {
            if let url = URL(string: viewModel.bookListDetailData.cover) {
                KFImage(url)
                    .placeholder {
                        ProgressView()
                            .frame(width: 100, height: 150)
                    }.retry(maxCount: 2, interval: .seconds(2))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 100, minHeight: 150)
            } else {
                EmptyBookView()
            }
            
            Text(viewModel.bookListDetailData.title)
                .font(.spoqaHans(type: .bold, size: 12))
                .foregroundStyle(Color.mainText)
                .frame(maxWidth: 246, maxHeight: 9)
                .kerning(-0.2)
            
            Text(viewModel.bookListDetailData.author)
                .font(.spoqaHans(type: .regular, size: 10))
                .foregroundStyle(.subText)
                .kerning(-0.2)
        })
    }
    
    /// 책 관련 저장된 데이터(총 페이지, 읽은 페이지, 북마크 수)
    private var bookInfoCount: some View {
        ZStack(alignment: .center, content: {
            RoundedRectangle(cornerRadius: 4)
                .fill(
                    Color.white
                )
                .frame(maxWidth: 369, maxHeight: 91)
                .shadow03()
            
            HStack(alignment: .center, spacing: 53, content: {
                BookCountComponent(count: viewModel.bookListDetailData.totalPage,
                                   title: "총 페이지")
                BookCountComponent(count: viewModel.bookListDetailData.finalPage,
                                   title: "읽은 페이지")
                BookCountComponent(count: viewModel.bookMarkData?.result.count ?? 0,
                                   title: "북마크 수")
            })
        })
    }
    
    /// 북마크 생성하기 버튼 및 페이지 업데이트 버튼
    private var btnGroup: some View {
        HStack(alignment: .center, spacing: 10, content: {
            makeBtn(title: "북마크 생성하기", action: {
                self.isShowBoookMarkMake = true
            }, color: Color.primaryDark)
            
            makeBtn(title: "페이지 업데이트", action: {
                withAnimation(.easeInOut) {
                    self.isShowCountEdit = true
                }
            }, color: Color.primary1)
        })
        .padding(.vertical, 10)
    }
    // MARK: - Bottom BookMarkView
    
    /// 하단 북마크 담당 뷰
    private var bottomBookMarkView: some View {
        VStack(alignment: .center, spacing: 5, content: {
            emotionBtnList
            bookMarkList
        })
        
    }
    
    /// 북마크 조회 감정 버튼
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
    
    /// 북마크 리스트 조회
    private var bookMarkList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if !filteredMark().isEmpty {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 0, maximum: 64), spacing: 15), count: 4), spacing: 15, content: {
                    ForEach(filteredMark(), id: \.self) { data in
                        Icon.icon(for: data.emotion).image
                            .resizable()
                            .frame(maxWidth: 50, maxHeight: 50)
                            .aspectRatio(contentMode: .fit)
                            .padding([.vertical, .horizontal], 5)
                            .onTapGesture {
                                self.selectedBookMark = data
                                DispatchQueue.main.async {
                                    self.isShowBookMarkInfo = true
                                }
                            }
                            .sheet(item: $selectedBookMark) { selectedBookMark in
                                BookMarkReadView(bookMarkId: selectedBookMark.bookMarkId)
                                    .presentationDetents([.fraction(0.7)])
                                    .presentationDragIndicator(.visible)
                            }
                    }
                })
                .padding(.vertical, 15)
                .refreshable {
                    viewModel.getBookMark(id: viewModel.bookListDetailData.myBookId)
                }
                .frame(maxWidth: .infinity, maxHeight: 380)
            } else {
                noBookMarkList
            }
        }
    }
    
    private var noBookMarkList: some View {
        VStack(alignment: .center, spacing: 34, content: {
            Icon.sadSpud.image
                .resizable()
                .frame(maxWidth: 126, maxHeight: 140)
                .aspectRatio(contentMode: .fit)
            Text("등록된 북마크가 없습니다.")
                .font(.spoqaHans(type: .bold, size: 18))
                .foregroundStyle(Color.gray06)
        })
        .padding(.top, 10)
    }
    
    
    // MARK: - Function
    
    /// 필터에 맞는 북마크 조회
    /// - Returns: 해당 감정에 대응하는 북마크 조회
    private func filteredMark() -> [BookMarkDetailData] {
        switch isSelected {
        case .happy:
            return viewModel.bookMarkData?.result.filter { $0.emotion == "JOY" } ?? []
        case .sad:
            return viewModel.bookMarkData?.result.filter { $0.emotion == "SADNESS" } ?? []
        case .angry:
            return viewModel.bookMarkData?.result.filter { $0.emotion == "ANGER" } ?? []
        case .inspiration:
            return viewModel.bookMarkData?.result.filter { $0.emotion == "INSPIRATION" } ?? []
        case .move:
            return viewModel.bookMarkData?.result.filter { $0.emotion == "MOVED" } ?? []
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
