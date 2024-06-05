//
//  BookListDetailData.swift
//  BookSpud
//
//  Created by 정의찬 on 6/3/24.
//

import Foundation

struct BookMarkData: Hashable {
    var information: [BookMarkDetailData]
}

struct BookMarkDetailData: Hashable {
    var emotion: String
    var bookMarkVerses: String
    var bookMarkMemo: String
}

final class BookMarkList {
    static let data: BookMarkData = BookMarkData(information: [
        BookMarkDetailData(emotion: "happy", bookMarkVerses: "하하호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "happy", bookMarkVerses: "호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "happy", bookMarkVerses: "가나다라마", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "happy", bookMarkVerses: "가나", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "happy", bookMarkVerses: "정말 재밌있어요", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "happy", bookMarkVerses: "훙에", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "happy", bookMarkVerses: "헤에", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "happy", bookMarkVerses: "흐아아아잉", bookMarkMemo: "흐아하하"),

        BookMarkDetailData(emotion: "sad", bookMarkVerses: "하하", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "sad", bookMarkVerses: "하호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "sad", bookMarkVerses: "하호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "sad", bookMarkVerses: "호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "sad", bookMarkVerses: "헤헤", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "sad", bookMarkVerses: "흐흐", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "angry", bookMarkVerses: "하하호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "angry", bookMarkVerses: "하하호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "angry", bookMarkVerses: "하하호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "angry", bookMarkVerses: "하하호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "inspiration", bookMarkVerses: "하하호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "inspiration", bookMarkVerses: "하하호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "inspiration", bookMarkVerses: "하하호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "inspiration", bookMarkVerses: "하하호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "move", bookMarkVerses: "하하호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "move", bookMarkVerses: "하하호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "move", bookMarkVerses: "하하호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "move", bookMarkVerses: "하하호호", bookMarkMemo: "흐아하하"),
        BookMarkDetailData(emotion: "move", bookMarkVerses: "하하호호", bookMarkMemo: "흐아하하")
    ])
}
