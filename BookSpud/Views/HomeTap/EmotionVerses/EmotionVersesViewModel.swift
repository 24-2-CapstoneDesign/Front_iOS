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
    @Published var spudFace: SwiftUI.Image = Icon.happySpud.image
    @Published var selectedEmotionImage: SwiftUI.Image = Icon.happyEmotion.image
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
    
    public func changeEmotionImage(_ image: SwiftUI.Image) {
        switch image {
        case Icon.happyEmotion.image:
            self.spudFace = Icon.happySpud.image
            self.selectedEmotionImage = Icon.happyEmotion.image
        case Icon.sadEmotion.image:
            self.spudFace = Icon.sadSpud.image
            self.selectedEmotionImage = Icon.sadEmotion.image
        case Icon.angryEmotion.image:
            self.spudFace = Icon.angrySpud.image
            self.selectedEmotionImage = Icon.angryEmotion.image
        case Icon.inspirationEmotion.image:
            self.spudFace = Icon.inspirationSpud.image
            self.selectedEmotionImage = Icon.inspirationEmotion.image
        case Icon.moveEmotion.image:
            self.spudFace = Icon.sensationSpud.image
            self.selectedEmotionImage = Icon.moveEmotion.image
        default:
            break
        }
    }
    
    
    /// 피커뷰 이이지 클릭시 작동 버튼(피커뷰 아웃)
    public func easeOutAnimationEffect() {
        withAnimation(.easeOut(duration: 0.5)) {
            self.isEmotionPickerViewAnimation = false
            self.isEmotionPickerPresented = false
        }
    }
}
