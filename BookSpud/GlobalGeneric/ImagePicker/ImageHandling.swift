//
//  ImageHandling.swift
//  BookSpud
//
//  Created by 정의찬 on 4/28/24.
//

import Foundation
import SwiftUI

protocol ImageHandling: AnyObject {
    func addImage(_ images: UIImage?) // 이미지 추가 함수
    func showImagePicker() // 이미지 피커 불러오기
    
    var isImagePickerPresendted: Bool { get set } // 이미지 피커 선택되었는지 확인
    var selectedImage: UIImage? { get }
}
