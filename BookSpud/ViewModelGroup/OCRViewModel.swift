//
//  OCRViewModel.swift
//  BookSpud
//
//  Created by 정의찬 on 6/4/24.
//


import Foundation
import SwiftUI
import Vision
import VisionKit

class OCRViewModel: ObservableObject {
    @Published var isShowOCR: Bool = false
    @Published var recognizedText = "" {
        didSet {
            sentences = recognizedText.split(separator: ".").map { String($0).trimmingCharacters(in: .whitespaces) + "." }
        }
    }
    @Published var sentences: [String] = []
    @Published var selectedText: String = ""

    func recognizeText(from image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { (request, error) in
            if let observations = request.results as? [VNRecognizedTextObservation] {
                self.recognizedText = observations.compactMap { observation in
                    observation.topCandidates(1).first?.string
                }.joined(separator: " ")
            }
        }

        request.recognitionLanguages = ["ko-KR"]
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true

        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the request: \(error).")
        }
    }
}
