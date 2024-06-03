//
//  FirendConnectingData.swift
//  BookSpud
//
//  Created by 정의찬 on 5/21/24.
//

import Foundation

struct BookRecommendData: Codable, Hashable {
    var information: [BookRecommendDetailData]
}

struct BookRecommendDetailData: Codable, Hashable{
    var bookCoverUrl: String
    var bookName: String
    var author: String
    var price: Int
    var sale: Int
    var introduce: String
    var purchaseURL: String
}


final class sampleDataLists {
    static let datalist = BookRecommendData(information: [
        
        BookRecommendDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788952776372.jpg", bookName: "리틀 라이프 1", author: "야나기하라", price: 14800, sale: 13320, introduce: "한야 야나기하라의 장편소설『리틀 라이프』. 어린 시절 끔찍한 학대와 폭력의 트라우마를 간직한 비밀스러운 인물 주드의 이야기가 펼쳐진다. 자신에게 주어진 삶의 부당함을 넘어서려 했던 남자, 살아내기 위해 스스로를 파괴해야 했던 한 남자의 삶을 그린 이 작품은, 한 가닥 희망의 가능성마저 거부하며 생의 고통을 정면으로 마주하게 한다.", purchaseURL: "https://product.kyobobook.co.kr/detail/S000000733954"),
        
        BookRecommendDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791193937105.jpg", bookName: "그럼에도 불구하고 나는 내가 좋았습니다.", author: "박채린", price: 18000, sale: 16200, introduce: "100만 유튜버라는 반짝이는 트로피를 들고 커리어의 꼭짓점에 서 있던 박채린. 하루아침에 그녀를 둘러싼 거짓과 추측이 퍼지며 갑자기 나락의 골짜기로 떨어져 나뒹굴게 되었다. 크리에이터로 다시는 재기할 수 없을 것이란 생각에 매일 아침 눈 뜨는 자신을 저주했던 그때였다.", purchaseURL: "https://product.kyobobook.co.kr/detail/S000000733954"),
        
        BookRecommendDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791193282069.jpg", bookName: "니체 인생수업", author: "프리드리히", price: 17500, sale: 15750, introduce: "니체 인생수업: 니체가 세상에 남긴 66가지", purchaseURL: "https://product.kyobobook.co.kr/detail/S000212773396"),
        
        BookRecommendDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791193937068.jpg", bookName: "부자의 마지막 가르침", author: "야나기하라", price: 19800, sale: 17820, introduce: "독자들이 선택하는 비즈니스 종합 그랑프리 1위, 출간 90일 만에 15만 부, 아마존 재팬 종합 1위를 기록하며 경제경영 교양 도서의 새로운 흐름으로 자리매김한 『부자의 마지막 가르침』은 골드만삭스 출신의 금융 전문가이자 사회 금융 교육가로서 활발한 강연과 집필을 펼치고 있는 베스트셀러 작가 다우치 마나부의 부자학 정수가 담긴 경제경영 교양서이다", purchaseURL: "https://product.kyobobook.co.kr/detail/S000000733954"),
        
        BookRecommendDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791198517425.jpg", bookName: "불변의 법칙", author: "모건 하우절", price: 25000, sale: 22500, introduce: "세계적인 베스트셀러 《돈의 심리학》의 저자 모건 하우절이 3년 만에 세상에 내놓은 신작.‘절대 변하지 않는 것들에 대한 23가지 이야기’를 전한다. 출간하자마자 아마존과 뉴욕타임스 베스트셀러 자리에 오르며 아마존 독자들과 오피니언 리더들의 극찬을 받았다.", purchaseURL: "https://product.kyobobook.co.kr/detail/S000212321676"),
        
        BookRecommendDetailData(bookCoverUrl: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791198682505.jpg", bookName: "나를 소모하지 않는 현명한 태도", author: "마티아스 뇔케", price: 17800, sale: 16020, introduce: "더 성공해야 하고, 더 노력해야 하고, 더 욕망해야 하고, 더 보여줘야 한다는 강박이 난무하는 시대다. 그러나 모두가 자기를 내세우고 드러내느라 시끄러운 세상에서는 역설적으로 절제된 말과 행동, 고요함과 평온함이 더 절실히 그리워지고, 더 강력하게 다가오기 마련이다. 『나를 소모하지 않는 현명한 태도에 관하여』는 모든 것이 과하게 요구되고, 요란하게 소비되는 시대에 ‘더 현명한 삶의 방식’은 무엇인지를 통찰한 책이다. 독일의 언론인이자 베스트셀러 작가이며 문학과 커뮤니케이션 과학, 심리학 등을 두루 공부한 마티아스 뇔케 박사는 특유의 재치와 명쾌함이 돋이는 글쓰기로 ‘보여주기 위해 극대화하는 삶이 아닌 조용히 나를 지키는 삶’으로 독자들을 안내한다.", purchaseURL: "https://product.kyobobook.co.kr/detail/S000212647841"),
    ])
    
}
