//
//  EmotionVersesViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 5/17/24.
//

import Foundation
import SwiftUI
import Combine
import Moya

/// 홈태의 감정 구절 랜덤으로 보는 뷰모델
class EmotionVersesViewModel: ObservableObject {
    
    // MARK: - Property
    
    /* EmotionVerses  Propert */
    @Published var authorImage: SwiftUI.Image?
    @Published var spudFace: SwiftUI.Image
    @Published var selectedEmotionImage: SwiftUI.Image
    @Published var isEmotionPickerPresented: Bool
    @Published var isEmotionPickerViewAnimation: Bool
    
    /* BookPoster */
    @Published var bookCover: SwiftUI.Image?
    
    /* API DataModel */
    @Published var bookVersesData: DetailBookVerses?
    private let provider: MoyaProvider<EmotionVersesAPI>
    
    // MARK: - Init
    
    init(
        authorImage: SwiftUI.Image? = nil,
        spudFace: SwiftUI.Image = Icon.happySpud.image,
        selectedEmotionImage: SwiftUI.Image = Icon.happyEmotion.image,
        isEmotionPickerPresented: Bool = false,
        isEmotionPickerViewAnimation: Bool = false,
        bookCover: SwiftUI.Image? = nil,
        bookVersesData: DetailBookVerses? = nil,
        provider: MoyaProvider<EmotionVersesAPI> = APIManager.shared.createProvider(for: EmotionVersesAPI.self)
    ) {
        
        self.authorImage = authorImage
        self.spudFace = spudFace
        self.selectedEmotionImage = selectedEmotionImage
        self.isEmotionPickerPresented = isEmotionPickerPresented
        self.isEmotionPickerViewAnimation = isEmotionPickerViewAnimation
        self.bookCover = bookCover
        self.bookVersesData = bookVersesData
        self.provider = provider
    }
    
    // MARK: - PickerFunction
    
    /// 감정 선택 피커뷰 등장 애니메이션 처리
    public func chagePickerPresented() {
        withAnimation(.easeIn(duration: 0.5)) {
            self.isEmotionPickerPresented.toggle()
        }
    }
    
    /// 감정 글자 선택 시 변경될 아이콘 및 감정 글자
    /// - Parameter image: 감정 이미지
    public func changeEmotionImage(_ image: SwiftUI.Image) {
        switch image {
        case Icon.happyEmotion.image:
            self.spudFace = Icon.happySpud.image
            self.selectedEmotionImage = Icon.happyEmotion.image
            getVerses(emotion: "JOY")
        case Icon.sadEmotion.image:
            self.spudFace = Icon.sadSpud.image
            self.selectedEmotionImage = Icon.sadEmotion.image
            getVerses(emotion: "SADNESS")
        case Icon.angryEmotion.image:
            self.spudFace = Icon.angrySpud.image
            self.selectedEmotionImage = Icon.angryEmotion.image
            getVerses(emotion: "ANGER")
        case Icon.inspirationEmotion.image:
            self.spudFace = Icon.inspirationSpud.image
            self.selectedEmotionImage = Icon.inspirationEmotion.image
            getVerses(emotion: "INSPIRATION")
        case Icon.moveEmotion.image:
            self.spudFace = Icon.sensationSpud.image
            self.selectedEmotionImage = Icon.moveEmotion.image
            getVerses(emotion: "MOVED")
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
    
    // MARK: - EmotionPicker API
    
    /// 북 구절 랜덤 생성 API
    /// - Parameter emotion: 선택한 감정
    public func getVerses(emotion: String) {
        provider.request(.bookMarkVerses(emotion: emotion)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleResponse(response: response)
            case .failure(let error):
                print("구절 네트워크 오류: \(error)")
            }
        }
    }
    
    /// 북 구절 랜덤 생성 API 처리
    /// - Parameter response: 호출 시 응답처리
    private func handleResponse(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(BookVerses.self, from: response.data)
            bookVersesData = decodedData.result
            print("북 구절 받아오기 완료")
        } catch {
            bookVersesData = nil
            print("구절 정보 안 들어 있음: \(error)")
            
        }
    }
}
