//
//  EmotionVersesViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/17/24.
//

import Foundation
import SwiftUI

class EmotionVersesViewModel: ObservableObject {
    
    // MARK: - Property
    
    /* ImagCache */
    
    private let imageCacheManager = ImageCacheManager.shared
    
    /* EmotionVerses  Propert */
    @Published var selectedEmotionImage: SwiftUI.Image = Icon.happyEmtion.image
    @Published var isEmotionPickerPresented: Bool = false
    @Published var isEmotionPickerViewAnimation = false
    
    /* BookPoster */
    @Published var bookPosterImg: SwiftUI.Image?
    var isDefaultPosterImage: Bool {
        return bookPosterImg == Icon.emptyBookPoster.image
    }
    
    /* API DataModel */
    @Published var bookVerses: BookVerses? = BookVerses(verses: "asdasd", bookName: "Asdsd", bookImgURL: "https://image.yes24.com/goods/85931281/XL")
    
    // MARK: - Function
    
    /// 감정 선택 피커뷰
    public func chagePickerPresented() {
        withAnimation(.easeIn(duration: 0.5)) {
            self.isEmotionPickerPresented.toggle()
        }
    }
    
    /// 비동기 북포스터 로딩
    public func showBookPosterImg() async {
        guard let bookPosterURLString = bookVerses?.bookImgURL, let url = URL(string: bookPosterURLString) else {
            DispatchQueue.main.async {
                self.bookPosterImg = Icon.emptyBookPoster.image
            }
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.bookPosterImg = Image(uiImage: uiImage)
                }
            } else {
                DispatchQueue.main.async {
                    self.bookPosterImg  = Icon.emptyBookPoster.image
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.bookPosterImg = Icon.emptyBookPoster.image
            }
        }
    }
    
    
    /// 피컵 이이지 클릭시 작동 버튼(피커뷰 아웃)
    public func easeOutAnimationEffect() {
        withAnimation(.easeOut(duration: 0.5)) {
            self.isEmotionPickerViewAnimation = false
            self.isEmotionPickerPresented = false
        }
    }
}
