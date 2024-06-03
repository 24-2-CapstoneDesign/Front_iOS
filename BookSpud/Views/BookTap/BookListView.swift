//
//  BookView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/11/24.
//

import SwiftUI

struct BookListView: View {
    
    @StateObject var viewModel = BookListViewModel()
    @State var selectedStatus: ReadingStatus = .nonStarted
    
    let data = dataList.data
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center,spacing: 20, content: {
                bookListNavigation
                bookListsCard
            })
            .ignoresSafeArea(.all)
            .background(Color.backgrounYellow)
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
    
    //TODO: - API 연결하기
    
    /// 책 리스트 뷰
//    private var bookListsCard: some View {
//        ScrollView(.vertical, showsIndicators: false,
//                   content: {
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 0, maximum: 181), spacing: 20), count: 2), spacing: 14, content: {
//                ForEach(viewModel.bookListBookData?.information ?? [], id: \.self) { information in
//                    BookListCardView(viewModel: BookListCardViewModel(bookListDetailData: information))
//                }
//            })
//        })
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
    
    /// 책 리스트 더미데이터
    private var bookListsCard: some View {
        ScrollView(.vertical, showsIndicators: false,
                   content: {
            if filteredBooks().isEmpty {
                emptyListView
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 0, maximum: 180), spacing: 20), count: 2), spacing: 14, content: {
                    ForEach(filteredBooks(), id: \.self) { information in
                        NavigationLink(destination: BookListDetailView(viewModel: BookDetailViewModel(bookListDetailData: information))) {
                            BookListCardView(viewModel: BookListCardViewModel(bookListDetailData: information))
                        }
                    }
                })
            }
        })
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
//    private func filteredBooks() -> [BookListDetailData] {
//            switch selectedStatus {
//            case .nonStarted:
//                return viewModel.bookListBookData?.information.filter { $0.readingProgress == 0 } ?? []
//            case .reading:
//                return viewModel.bookListBookData?.information.filter { $0.readingProgress > 0 && $0.readingProgress < 1 } ?? []
//            case .completed:
//                return viewModel.bookListBookData?.information.filter { $0.readingProgress == 1 } ?? []
//            }
//        }
    
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
        })
        .frame(height: 400)
    }
    
    
    // MARK: - Function
    
    private func filteredBooks() -> [BookListDetailData] {
            switch selectedStatus {
            case .nonStarted:
                return data.information.filter { $0.readingProgress == 0 }
            case .reading:
                return data.information.filter { $0.readingProgress > 0 && $0.readingProgress < 1 }
            case .completed:
                return data.information.filter { $0.readingProgress == 1 }
            }
        }
    
}


struct BookListView_Preview: PreviewProvider {
    static let devices = ["iPhone 11", "iPhone 15 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            BookListView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
