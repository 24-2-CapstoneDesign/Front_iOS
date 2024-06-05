//
//  ReportDraftViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/5/24.
//

import Foundation
import SwiftUI
import Combine

class ReportDraftViewModel: ObservableObject {
    @Published var currentPageIndex: Int = 0
    @Published var bookCover: Image?
    
    // MARK: - ArgumentView
    
    @Published var selectedArgument: String? = nil {
        didSet {
            if selectedArgument != nil {
                checkZeroBtn = true
            }
        }
    }
    @Published var checkZeroBtn: Bool = false
    
    // MARK: - Answer
    
    /* FirstView(서론) */
    @Published var firstAnswer: String = "" {
        didSet {
            if !firstAnswer.isEmpty {
                checkFirstBtn = true
            }
        }
    }
    @Published var checkFirstBtn: Bool = false
    
    /* SecondView(본론) */
    @Published var secondAnswer: String = "" {
        didSet {
            if !secondAnswer.isEmpty {
                checkSecondBtn = true
            }
        }
    }
    @Published var checkSecondBtn: Bool = false
    
    /* thirdView(결론) */
    @Published var thirdAnswer: String = "" {
        didSet {
            if !thirdAnswer.isEmpty {
                checkThirdBtn = true
            }
        }
    }
    
    @Published var checkThirdBtn: Bool = false
    
    let imageCache = ImageCacheManager.shared
    private var cancellable: AnyCancellable?
    
    // MARK: - ImageFunction
    
    public func loadImage(from url: URL) {
        if let cachedImage = imageCache.loadImageData(from: url) {
            self.bookCover = cachedImage
        } else {
            downloadImage(from: url)
        }
    }
    
    private func downloadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .catch { _ in Just(Data()) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in}, receiveValue: {
                [weak self] data in
                guard !data.isEmpty, let self = self else { return }
                imageCache.downloadAndSaveImage(from: url)
                if let uiImage = UIImage(data: data) {
                    self.bookCover = Image(uiImage: uiImage)
                }
            })
    }
}
