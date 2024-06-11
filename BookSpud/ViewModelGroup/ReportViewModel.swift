//
//  ReportViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation
import Moya
import SwiftUI

class ReportViewModel: ObservableObject {
    @Published var reportData: ReportData?
    
    private let provider: MoyaProvider<ReportAPITarget>
    
    // MARK: - Init
    
    init(provider: MoyaProvider<ReportAPITarget> = APIManager.shared.testProvider(for: ReportAPITarget.self)) {
        self.provider = provider
    }
    
    // MARK: - API Function
    
    /// 독후감 전체 조회 API Function
    public func getReportData() {
        provider.request(.getReport) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleGetReportData(response: response)
            case .failure(let error):
                print("독후감 받아오기 네트워크 오류: \(error)")
            }
        }
    }
    
    /// 독후감 전체 조회 핸들러
    /// - Parameter response: 독후감 API response
    private func handleGetReportData(response: Response) {
        do {
            let decodedData = try JSONDecoder().decode(ReportData.self, from: response.data)
            self.reportData = decodedData
        } catch {
            print("독후감 받아오기 디코더 오류 : \(error)")
        }
    }
}
