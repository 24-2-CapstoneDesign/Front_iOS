//
//  ReportViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya
import Combine
import SwiftUI

class ReportViewModel: ObservableObject {
    @Published var reportData: ReportData?
    @Published var bookCover: SwiftUI.Image? = nil
    
    private var imageCache = ImageCacheManager.shared
    private var cancellable: AnyCancellable?
    
    // MARK: - API Property
    private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    var provider: MoyaProvider<ReportAPITarget>
    
    init() {
        tokenProvider = TokenProvider()
        accessTokenRefresher = AccessTokenRefresher(tokenProvider: tokenProvider)
        session = Session(interceptor: accessTokenRefresher)
        provider = MoyaProvider<ReportAPITarget>(session: session)
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
    
    public func loadImage(from url: URL) {
        if let cachedImage = imageCache.loadImageData(from: url) {
            self.bookCover = cachedImage
        } else {
            downloadImage(from: url)
        }
    }
    
    public func getReportData() {
        provider.request(.getReport) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ReportData.self, from: response.data)
                    self?.reportData = decodedData
                } catch {
                    print("독후감 받아오기 디코더 오류 : \(error)")
                }
            case .failure(let error):
                print("독후감 받아오기 네트워크 오류: \(error)")
            }
        }
               
    }
}
