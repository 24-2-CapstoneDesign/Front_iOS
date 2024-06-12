//
//  SpudViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/12/24.
//

import Foundation
import Moya


class SpudViewModel: ObservableObject {
    
    @Published var spudPointData: SpudPointData?
    @Published var currentCharacterIdx: Int = 0
    
    let spudData = ["kindergarden", "elementary", "middle", "high", "college", "employee"]
    let spudUpPoint = [100, 200, 300, 400, 500, 600]
    
    let provider: MoyaProvider<GetPoinAPITarget>
    
    init(provider: MoyaProvider<GetPoinAPITarget> = APIManager.shared.testProvider(for: GetPoinAPITarget.self)) {
        self.provider = provider
    }
    
    public func fetchPoint() {
        provider.request(.getPoint) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(SpudPointData.self, from: response.data)
                    self?.spudPointData = decodedData
                    self?.fetchIdx()
                    print(decodedData)
                } catch {
                    print("포인트 디코드 에러 : \(error)")
                }
            case .failure(let error):
                print("포인트 네트워크 에러: \(error)")
            }
        }
    }
    
    private func fetchIdx() {
        guard let point = spudPointData?.result.point else { return }
        if point < 100 {
            self.currentCharacterIdx = 0
        } else if point >= 100 && point < 200 {
            self.currentCharacterIdx = 1
        } else if point >= 200 && point < 300 {
            self.currentCharacterIdx = 2
        } else if point >= 300 && point < 400 {
            self.currentCharacterIdx = 3
        } else if point >= 400 && point < 500 {
            self.currentCharacterIdx = 4
        }
        
        
    }
}
