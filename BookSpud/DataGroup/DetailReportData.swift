//
//  DetailReportData.swift
//  BookSpud
//
//  Created by 정의찬 on 6/7/24.
//

import Foundation

// MARK: 독후감 상세 조회

struct DetailReportData: Codable {
    var status: Int
    var message: String
    var result: DetailReportDataResult
}

struct DetailReportDataResult: Codable {
    var intro: String
    var introEmotion: String
    var body: String
    var bodyEmotion: String
    var conclusion: String
    var conclusionEmotion: String
}


// MARK: - 최종본 생성

struct InputEmotionData: Codable {
    var introEmotion: String
    var bodyEmotion: String
    var conclusionEmotion: String
}

struct ResponseEmotionData: Codable {
    var status: Int
    var message: String
}


// MARK: - 초안 생성
struct MakeDraft: Codable {
    var introQuestion: String
    var introAnswer: String
    var bodyQuestion: String
    var bodyAnswer: String
    var conclusionQuestion: String
    var conclusionAnswer: String
}

struct ResponseMakeDraft: Codable {
    var status: Int
    var message: String
    var result: ResultMakeDraft
}

struct ResultMakeDraft: Codable {
    var intro: String
    var body: String
    var conclusion: String
}

// MARK: - 논점 생성

/// 논점 받아오는 데이터
struct DraftReportData: Codable {
    var status: Int
    var message: String
    var result: Arguments
}

struct Arguments: Codable {
    var arguments: [String]
}



/// 논점 전달 후, 논점 id 데이터
struct ResponseArguments: Codable {
    var status: Int
    var message: String
    var result: ResponseArgumentsResult
}

struct ResponseArgumentsResult: Codable {
    var id: Int
}

// MARK: - 서론 본론 결론 질문 조회

struct ResponseAnswer: Codable {
    var status: Int
    var message: String
    var result: ResponseAnswerResult
}

struct ResponseAnswerResult: Codable {
    var introQuestion: String
    var bodyQuestion: String
    var conclusionQuestion: String
}


// MARK: - 감정 조회

struct ResponseEmotionPatch: Codable {
    var status: Int
    var message: String
}


struct ShowDetailBook: Codable {
    var status: Int
    var message: String
    var result: ShowDetailBookResult
}

struct ShowDetailBookResult: Codable {
    var intro: String
    var introEmotion: String?
    var body: String
    var bodyEmotion: String?
    var conclusion: String
    var conclusionEmotion: String?
}

// MARK: - 감정 입력 질문 가이드

struct EmotionGuide: Codable {
    var status: Int
    var message: String
    var result: EmotionGuideResult
}

struct EmotionGuideResult: Codable {
    var questionGuides: [EmotionGuideQuestion]
}

struct EmotionGuideQuestion: Codable {
    var question: String
}
