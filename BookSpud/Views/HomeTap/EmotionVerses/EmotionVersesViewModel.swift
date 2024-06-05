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
    @Published var bookVerses: BookVerses? = BookVerses(verses: "기분이 형편없고 걱정할 것이 한가득해도, 긍정적인 것을 찾을 수 있다.", bookName: "긍정 효과", bookImgURL: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791190227322.jpg")
    
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
            self.bookVerses = BookVerses(verses: "기분이 형편없고 걱정할 것이 한가득해도, 긍정적인 것을 찾을 수 있다.", bookName: "긍정 효과", bookImgURL: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791190227322.jpg")
        case Icon.sadEmotion.image:
            self.spudFace = Icon.sadSpud.image
            self.selectedEmotionImage = Icon.sadEmotion.image
            self.bookVerses = BookVerses(verses: "시간을 낭비하는다는 건 시도했는데 잘 안되거나 실패한게 아니다. 할 수 있는 일 들을 하지 않고 바라만 본 것이다.", bookName: "고민의 답", bookImgURL: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791192237022.jpg")
        case Icon.angryEmotion.image:
            self.spudFace = Icon.angrySpud.image
            self.selectedEmotionImage = Icon.angryEmotion.image
            self.bookVerses = BookVerses(verses: "상대방의 말을 앵무새처럼 활용하라", bookName: "고수의 대화법: 말감각", bookImgURL: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791190227186.jpg")
        case Icon.inspirationEmotion.image:
            self.spudFace = Icon.inspirationSpud.image
            self.selectedEmotionImage = Icon.inspirationEmotion.image
            self.bookVerses = BookVerses(verses: "'충분'한것도 결코 적은것이 아니다.", bookName: "돈의 심리학", bookImgURL: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791191056372.jpg")
        case Icon.moveEmotion.image:
            self.spudFace = Icon.sensationSpud.image
            self.selectedEmotionImage = Icon.moveEmotion.image
            self.bookVerses = BookVerses(verses: "목표를 향한 강렬한 몰입이 필요하다", bookName: "마지막 몰입", bookImgURL: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791162543665.jpg")
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
