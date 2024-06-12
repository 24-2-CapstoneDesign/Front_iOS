//
//  SpudView.swift
//  BookSpud
//
//  Created by 정의찬 on 5/11/24.
//

import SwiftUI

struct SpudView: View {
    
    @StateObject var viewModel: SpudViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: SpudViewModel())
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 30, content: {
            customeNavigation
            
            VStack(spacing: 30) {
                guideText
                spudImage
            }
            
            exampleImage
            
            Spacer()
        })
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(Color.backgrounYellow)
        .onAppear {
            viewModel.fetchPoint()
            
        }
    }
    
    
    private var customeNavigation: some View {
        CustomNavigation(title: "감자 키우기", chevron: nil, onOff: true)
    }
    
    private var spudImage: some View {
        VStack(alignment: .center, spacing: 30, content: {
            
            Image(viewModel.spudData[viewModel.currentCharacterIdx])
                .resizable()
                .frame(maxWidth: 250, maxHeight: 250)
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(
                    Circle()
                        .stroke(Color.primary1, lineWidth: 8)
                )
            
            changeProgressView(idx: viewModel.currentCharacterIdx)
        })
        
    }
    
    private var guideText: some View {
        Text("책을 등록하고 독후감을 작성해보세요! \n 열심히 해서 감자를 성장 시켜봐요!!")
            .font(.spoqaHans(type: .medium, size: 14))
            .foregroundStyle(Color.gray05)
            .multilineTextAlignment(.center)
            .lineSpacing(8)
    }
    
    @ViewBuilder
    private var exampleImage: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 0, maximum: 200), spacing: 10), count: 3), spacing: 15, content: {
            ForEach(viewModel.spudData.indices, id: \.self) { indice in
                VStack(alignment: .center, spacing: 5, content: {
                    PotatoCircle(image: Image(viewModel.spudData[indice]), maxWidth: 60, maxHeight: 60)
                        .overlay(
                            Rectangle()
                                .fill(Color.gray.opacity(indice <= viewModel.currentCharacterIdx ? 0 : 0.85))
                                .cornerRadius(30)
                        )
                    Text(changeName(name: viewModel.spudData[indice]))
                        .font(.spoqaHans(type: .medium, size: 12))
                        .foregroundStyle(indice <= viewModel.currentCharacterIdx ? Color.successDark : Color.gray05)
                })
                
            }
        })
    }
    
    
    public func changeName(name: String) -> String {
        switch name {
        case "kindergarden":
            return "유치원 감자"
        case "elementary":
            return "초등학생 감자"
        case "middle":
            return "중학생 감자"
        case "high":
            return "고등학생 감자"
        case "college":
            return "대학생 감자"
        case "employee":
            return "회사원 감자"
        default:
            return "유치원 감자"
        }
        
    }
    
    private func changeProgressView(idx: Int) -> CharacterProgressView {
        
        guard let point = viewModel.spudPointData?.result.point else { return CharacterProgressView(currentPoint: 0, totalPoint: 0) }
        
        switch idx {
        case 0:
            return CharacterProgressView(currentPoint: point, totalPoint: viewModel.spudUpPoint[idx], maxWidth: 145, maxHeight: 32)
        case 1:
            return CharacterProgressView(currentPoint: point, totalPoint: viewModel.spudUpPoint[idx], maxWidth: 145)
        case 2:
            return CharacterProgressView(currentPoint: point, totalPoint: viewModel.spudUpPoint[idx], maxWidth: 200)
        case 3:
            return CharacterProgressView(currentPoint: point, totalPoint: viewModel.spudUpPoint[idx], maxWidth: 240)
        case 4:
            return CharacterProgressView(currentPoint: point, totalPoint: viewModel.spudUpPoint[idx], maxWidth: 280)
        case 5:
            return CharacterProgressView(currentPoint: point, totalPoint: viewModel.spudUpPoint[idx], maxWidth: 320)
        default:
            return CharacterProgressView(currentPoint: 0, totalPoint: 0)
        }
    }
    
}

struct SpudViewPreview: PreviewProvider {
    static var previews: some View {
        SpudView()
    }
}
