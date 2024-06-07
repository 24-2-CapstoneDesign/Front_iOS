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

class EmotionVersesViewModel: ObservableObject {
    
    // MARK: - Property
    
    /* ImagCache */
    
    private let imageCache = ImageCacheManager.shared
    
    /* EmotionVerses  Propert */
    @Published var authorImage: SwiftUI.Image?
    @Published var spudFace: SwiftUI.Image = Icon.happySpud.image
    @Published var selectedEmotionImage: SwiftUI.Image = Icon.happyEmotion.image
    @Published var isEmotionPickerPresented: Bool = false
    @Published var isEmotionPickerViewAnimation = false
    
    /* BookPoster */
    @Published var bookCover: SwiftUI.Image?
    
    var isDefaultPosterImage: Bool {
        return bookCover == Icon.emptyBookPoster.image
    }
    
    /* API DataModel */
    @Published var bookVerses: DetailBookVerses?
    private var cancellable: AnyCancellable?
    
    
    // MARK: - API Property
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<EmotionVersesAPI>
    
    init() {
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<EmotionVersesAPI>(session: session)
    }
    
    // MARK: - Function
    
    /// 감정 선택 피커뷰
    public func chagePickerPresented() {
        withAnimation(.easeIn(duration: 0.5)) {
            self.isEmotionPickerPresented.toggle()
        }
    }
    
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
    
    // MARK: API
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
    
    private func handleResponse(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(BookVerses.self, from: response.data)
            bookVerses = decodedData.result
            print("북 구절 받아오기 완료")
        } catch {
            print("구절 정보 디코드 오류: \(error)")
        }
    }
    
    
    func loadImage(from url: URL) {
            if let cachedImage = ImageService.shared.loadImage(from: url) {
                self.authorImage = cachedImage
            } else {
                cancellable = URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
                    .catch { _ in Just(Data()) }
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] data in
                        guard !data.isEmpty, let self = self, let uiImage = UIImage(data: data) else { return }
                        ImageService.shared.downloadImage(from: url) { image in
                            self.authorImage = image
                        }
                    })
            }
        }
    
}
