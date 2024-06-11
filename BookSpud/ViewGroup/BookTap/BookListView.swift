//
//  BookView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/11/24.
//

import SwiftUI

struct BookListView: View {
    
    @StateObject var viewModel: BookListViewModel
    @State var selectedStatus: ReadingStatus
    
    init() {
        self._viewModel = StateObject(wrappedValue: BookListViewModel())
        self.selectedStatus = .nonStarted
    }
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center,spacing: 20, content: {
                bookListNavigation
                
                if filteredBooks().isEmpty {
                    emptyListView
                } else {
                    bookListsCard
                }
            })
            .ignoresSafeArea(.all)
            .background(Color.backgrounYellow)
            .onAppear {
                viewModel.getBookList()
            }
        }
    }
    
    
    // MARK: - BookListView
    
    /// 책 정보 상단 네비게이션
    private var bookListNavigation: some View {
        ZStack(alignment: .bottom, content: {
            TopRadiusView(radius: 0, height: 140)
            topNavigation
        })
        .frame(maxWidth: .infinity, maxHeight: 140)
    }
    
    ///
    private var topNavigation: some View {
        VStack(alignment: .leading, spacing: 14, content: {
            navigationTitle
            bookListSortBtn
        })
        .frame(maxWidth: 430)
    }
    
    /// 책 정보 상단 네비게이션
    private var navigationTitle: some View {
        HStack(alignment: .center, content: {

            Spacer()
            
            Text("책 정보")
                .font(.pretendard(type: .bold, size: 16))
                .kerning(-0.5)
            
            Spacer()
        })
        .frame(maxHeight: 40)
    }
    
    /// 상단 책 분류 버튼
    private var bookListSortBtn: some View {
        HStack(alignment: .bottom, spacing: 10, content: {
            BookStatusBtn(text: ReadingStatus.nonStarted.rawValue,
                         action: {
                withAnimation {
                    selectedStatus = .nonStarted
                }
            },
                         currentStatus: .nonStarted,
                         selected: $selectedStatus)
            
            BookStatusBtn(text: ReadingStatus.reading.rawValue,
                         action: {
                withAnimation {
                    selectedStatus = .reading
                }
            },
                         currentStatus: .reading,
                         selected: $selectedStatus)

            BookStatusBtn(text: ReadingStatus.completed.rawValue,
                         action: {
                withAnimation {
                    selectedStatus = .completed
                }
            },
                         currentStatus: .completed,
                         selected: $selectedStatus)
        })
        .frame(maxWidth: 430, alignment: .leading)
        .padding(.leading, 20)
    }
    
    
    
    /// 책 리스트 받아오기
    private var bookListsCard: some View {
        ScrollView(.vertical, showsIndicators: false,
                   content: {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 0, maximum: 180), spacing: 20), count: 2), spacing: 14, content: {
                ForEach(filteredBooks(), id: \.self) { book in
                    BookListCardView(bookData: book)
                }
            })
        })
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .refreshable {
            print("리프레시 진행")
            viewModel.getBookList()
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                viewModel.getBookList()
            }
        }
    }

    
    /// 등록된 책 데이터 없을 시 이미지 반환하기
    private var emptyListView: some View {
        VStack(alignment: .center, spacing: 25, content: {
            
            Spacer()
            
            Icon.sadSpud.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 126, maxHeight: 146)
            
            Text("등록된 책이 없습니다.")
                .font(.spoqaHans(type: .bold, size: 18))
                .kerning(-0.2)
                .foregroundStyle(Color.gray06)
            Spacer()
        })
    }
    
    // MARK: - Function
    
    /// 책 진행률에 따라 분류하기
    /// - Returns: 진행률에 따라 분류된 책 데이터 반환
    private func filteredBooks() -> [BookListDetailData] {
            switch selectedStatus {
            case .nonStarted:
                return viewModel.bookListBookData?.result.myBooks.filter { $0.readingProgress == 0 } ?? []
            case .reading:
                return viewModel.bookListBookData?.result.myBooks.filter { $0.readingProgress > 0 && $0.readingProgress < 1 } ?? []
            case .completed:
                return viewModel.bookListBookData?.result.myBooks.filter { $0.readingProgress == 1 } ?? []
            }
        }
    
}
