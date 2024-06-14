# 📖  독서 무한한 여정을 시작하다.  Book Spud

![리드미 홍보 화면](https://github.com/24-2-CapstoneDesign/Front_iOS/assets/80624315/80f6d71a-9ac2-4a25-bdc2-476f98f1fbb7)

&nbsp;

## 프로젝트 소개
- 독후감 작성 및 감정 표현 훈련
	- 학생들이 독서를 마친 후 독후감을 작성하거나 감정을 활용한 북마크를 사용해 자신의 생각과 감정을 표현할 수 있도록 돕는다. 이를 통해 창의적 자기 표현력과 비판적 사고력을 기르며, 독서의 즐거움과 만족감 경험한다.
- 감자를 통한 독서 동기 부여
	- 학생들은 독후감을 작성하거나 북마크를 사용하면서 게임 요소인 감자 캐릭터를 서장 시킬 수 있다. 이 시스템은 학생들이 자연스럽게 독서 습관을 형성하고, 자기만의 감정과 생각을 표현하는 즐거움을 경험하도록 설계되었다.
- 독서 기록 관리 및 ISBN 기반 독서 등록
	- 학생들은 아주 쉽고 빠르게 카메라로 ISBN을 스캔하여 책을 등록하여 읽은 도서를 주기적으로 추적하고 관리할 수 있다. 이를 통해 얼마나 많은 책을 읽었는지 파악하고, 자신의 독서 성장을 실감할 수 있다.
- Book To Book, Book To User 추천 시스템
	- 북마크를 저장할 때 OCR 판독 기능으로 인상 깊은 구절과 자신의 감정을 기록할 수 있다. Book To Book, Book To User 시스템을 통해 책을 추천 받고, 추천 받은 책의 감정을 기반으로 다른 학생들이 저장한 감정 북마크를 열람하여 책의 내용을 짧게 알아갈 수 있다. 이를 통해 학생들은 취향에 맞는 새로운 책을 찾거나 유사한 독서 성향을 가진 친구들과 독서를 추천하고 교류할 수 있다.

&nbsp;
## 팀원 구성

| 정의찬                                                                                                                                |
| ---------------------------------------------------------------------------------------------------------------------------------- |
| Front, Design                                                                                                                      |
| <img src = "https://github.com/24-2-CapstoneDesign/Front_iOS/assets/80624315/eacbaca2-453a-4366-ab9b-c35beea65a9b" width = "300"/> |

&nbsp;
## 1. 개발환경
- Front :  Xcode, SwiftUI, Vision Pro
- 버전 및 이슈 관리 : Github, Github Issues, GitHub Project
- 협업 툴 : Discord, Notion
- 서비스 배포 환경 : iOS 17 이상
- 디자인 : [Figma](https://www.figma.com/design/viKMnyFbGsMKs1lY20A0y7/%EA%B0%90%EC%9E%90%EA%B0%80%EC%A1%B1?node-id=550-1165&t=EHf8ecOnUtRz9r8T-1)
- GitMoji

&nbsp;
## 2. 개발 기술

### Image 캐싱
- KingFisher 사용
	- Book Spud 앱은 저장된 책, 추천된 책, 감자 등 중복적이면서 많은 사진을 로딩해야 한다.
	- 많은 사진들이 사용되는 앱의 특성상 효율적인 이미지 관리는 매우 중요하다.
	- 동시성 제어, 캐시 확인 후 요청 작업을 두어 동일안 URL에 대해 비동기 요청이 동시에 처리되지 않도록 동시성 제어 도입

### OCR
- Vision Pro OCR 기술 사용
	- 유저가 원하는 책 속의 구절을 선택해 저장할 수 있도록 텍스트 인식하기 위함
	- 책의 뒷표지에 등록되어 있는 ISBN을 인식하여 등록될 수 있도록 하기 위함
	- 높은 정확도와 한글 숫자 영어 전부 인식이 되어, 책 속의 구절을 인식 후 문장 단위로 끊어서 유저에게 선택할 수 있도록 했다.

&nbsp;

## 3. 프로젝트 구조

```
├── BookSpud
│   ├── APITartgetGroup
│   │   ├── BookListAPITarget.swift
│   │   ├── BookListDetailAPITarget.swift
│   │   ├── BookMarkReadAPITarget.swift
│   │   ├── BookMarkRegistAPITarget.swift
│   │   ├── BookRecommendAPI.swift
│   │   ├── BookRecommendDetailAPI.swift
│   │   ├── CreateBookAPITarget.swift
│   │   ├── EmotionChartAPITarget.swift
│   │   ├── EmotionVersesAPI.swift
│   │   ├── GetPoinAPITarget.swift
│   │   ├── KakaoBookAPITarget.swift
│   │   ├── LoginAPITarget.swift
│   │   ├── ProfileAPITarget.swift
│   │   └── ReportAPITarget.swift
│   ├── DataGroup
│   │   ├── BookListBookData.swift
│   │   ├── BookMarkData.swift
│   │   ├── BookMarkRegistData.swift
│   │   ├── BookRecommendData.swift
│   │   ├── CheckingUserBookData.swift
│   │   ├── DetailReportData.swift
│   │   ├── EmotionChartData.swift
│   │   ├── EmotionData.swift
│   │   ├── EmotionUserData.swift
│   │   ├── ReportData.swift
│   │   ├── ScanBookData.swift
│   │   └── SpudPointData.swift
│   ├── Fonts
│   │   ├── FontExtension.swift
│   │   ├── GangwonEduSaeeum.otf
│   │   ├── Pretendard
│   │   │   ├── Pretendard-Bold.otf
│   │   │   ├── Pretendard-Light.otf
│   │   │   ├── Pretendard-Medium.otf
│   │   │   ├── Pretendard-Regular.otf
│   │   │   └── Pretendard-SemiBold.otf
│   │   └── SpoqaHan
│   │       ├── SpoqaHanSansNeo-Bold.otf
│   │       ├── SpoqaHanSansNeo-Light.otf
│   │       ├── SpoqaHanSansNeo-Medium.otf
│   │       ├── SpoqaHanSansNeo-Regular.otf
│   │       └── SpoqaHanSansNeo-Thin.otf
│   ├── GlboalComponent
│   │   ├── CustomNavigation.swift
│   │   ├── CustomTextField.swift
│   │   ├── EmptyBookView.swift
│   │   ├── GlobalMainBtn.swift
│   │   ├── MainDotLine.swift
│   │   ├── MemoTextField.swift
│   │   ├── PotatoCircle.swift
│   │   ├── TopRadiusView.swift
│   │   ├── VersesBackground.swift
│   │   └── WritedMemo.swift
│   ├── GlobalFile
│   │   ├── ImageCacheManager
│   │   │   └── ImageCacheManager.swift
│   │   ├── ImageCacheManager.swift
│   │   ├── ImagePicker
│   │   │   ├── ImageHandling.swift
│   │   │   └── ShowImagePicker.swift
│   │   └── TokenRefresh
│   │       ├── APIManager.swift
│   │       ├── AccessTokenRefresher.swift
│   │       ├── AuthAPITarget.swift
│   │       ├── TokenProvider.swift
│   │       ├── TokenProviding.swift
│   │       └── TokenResponse.swift
│   ├── Info.plist
│   ├── Login
│   │   ├── Kakao
│   │   │   ├── KakaoLoginMananger.swift
│   │   │   └── LoginData.swift
│   │   ├── KeyChain
│   │   │   ├── KeyChainManager.swift
│   │   │   └── UserInfo.swift
│   │   └── LoginView.swift
│   ├── Preview Content
│   │   └── Preview Assets.xcassets
│   │       └── Contents.json
│   ├── Setting
│   │   ├── Assets.xcassets
│   │   │   ├── AccentColor.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── AppIcon.appiconset
│   │   │   │   ├── 1024.png
│   │   │   │   ├── 114.png
│   │   │   │   ├── 120 1.png
│   │   │   │   ├── 120.png
│   │   │   │   ├── 180.png
│   │   │   │   ├── 40.png
│   │   │   │   ├── 58.png
│   │   │   │   ├── 60.png
│   │   │   │   ├── 80.png
│   │   │   │   ├── 87.png
│   │   │   │   └── Contents.json
│   │   │   ├── BookMark
│   │   │   │   ├── Contents.json
│   │   │   │   ├── angryMark.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── angry.pdf
│   │   │   │   ├── happyMark.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── happy.pdf
│   │   │   │   ├── inspirationMark.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── inspiration.pdf
│   │   │   │   ├── moveMark.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── move.pdf
│   │   │   │   └── sadMark.imageset
│   │   │   │       ├── Contents.json
│   │   │   │       └── sad.pdf
│   │   │   ├── BtnImage
│   │   │   │   ├── Contents.json
│   │   │   │   └── inputISBN.imageset
│   │   │   │       ├── Contents.json
│   │   │   │       └── inputISBN.pdf
│   │   │   ├── Contents.json
│   │   │   ├── HomeTap
│   │   │   │   ├── BookVerses
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   ├── leftQuota.imageset
│   │   │   │   │   │   ├── Contents.json
│   │   │   │   │   │   └── leftQuata.pdf
│   │   │   │   │   └── rightQuota.imageset
│   │   │   │   │       ├── Contents.json
│   │   │   │   │       └── rightQuta.pdf
│   │   │   │   ├── Contents.json
│   │   │   │   ├── EmotionVerses
│   │   │   │   │   ├── ANGER.imageset
│   │   │   │   │   │   ├── Contents.json
│   │   │   │   │   │   └── angryEmotion.pdf
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   ├── INSPIRATION.imageset
│   │   │   │   │   │   ├── Contents.json
│   │   │   │   │   │   └── inspirationEmotion.pdf
│   │   │   │   │   ├── JOY.imageset
│   │   │   │   │   │   ├── Contents.json
│   │   │   │   │   │   └── happyEmtion.pdf
│   │   │   │   │   ├── MOVED.imageset
│   │   │   │   │   │   ├── Contents.json
│   │   │   │   │   │   └── moveEmotion.pdf
│   │   │   │   │   ├── SADNESS.imageset
│   │   │   │   │   │   ├── Contents.json
│   │   │   │   │   │   └── sadEmotion.pdf
│   │   │   │   │   ├── angryEmotion.imageset
│   │   │   │   │   │   ├── Contents.json
│   │   │   │   │   │   └── angryEmotion.pdf
│   │   │   │   │   ├── emotionBackground.imageset
│   │   │   │   │   │   ├── Contents.json
│   │   │   │   │   │   └── emotionBackground.pdf
│   │   │   │   │   ├── emptyBookPoster.imageset
│   │   │   │   │   │   ├── Contents.json
│   │   │   │   │   │   └── emptyBookPoster.pdf
│   │   │   │   │   ├── happyEmotion.imageset
│   │   │   │   │   │   ├── Contents.json
│   │   │   │   │   │   └── happyEmtion.pdf
│   │   │   │   │   ├── inspirationEmotion.imageset
│   │   │   │   │   │   ├── Contents.json
│   │   │   │   │   │   └── inspirationEmotion.pdf
│   │   │   │   │   ├── moveEmotion.imageset
│   │   │   │   │   │   ├── Contents.json
│   │   │   │   │   │   └── moveEmotion.pdf
│   │   │   │   │   ├── sadEmotion.imageset
│   │   │   │   │   │   ├── Contents.json
│   │   │   │   │   │   └── sadEmotion.pdf
│   │   │   │   │   └── versesBorder.imageset
│   │   │   │   │       ├── Contents.json
│   │   │   │   │       └── versesBorder.pdf
│   │   │   │   └── TopUserData
│   │   │   │       ├── Contents.json
│   │   │   │       ├── cutyPotato.imageset
│   │   │   │       │   ├── Contents.json
│   │   │   │       │   └── cutyPotato.png
│   │   │   │       └── optionBtn.imageset
│   │   │   │           ├── Contents.json
│   │   │   │           └── optionBtn.pdf
│   │   │   ├── ISBN
│   │   │   │   ├── Contents.json
│   │   │   │   ├── exiteCamera.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── exiteCamera.pdf
│   │   │   │   ├── manualCode.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── manualCode.pdf
│   │   │   │   ├── resgistISBN.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── resgistISBN.pdf
│   │   │   │   └── scanGuide.imageset
│   │   │   │       ├── Contents.json
│   │   │   │       └── scanGuide.pdf
│   │   │   ├── Login
│   │   │   │   ├── Contents.json
│   │   │   │   ├── iosLogin.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── iosLogin.pdf
│   │   │   │   ├── kakaoLogin.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── kakaoLogin.pdf
│   │   │   │   └── logo.imageset
│   │   │   │       ├── Contents.json
│   │   │   │       └── logo.png
│   │   │   ├── Profil
│   │   │   │   ├── Contents.json
│   │   │   │   ├── nickNameCheck.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── nickNameCheck.pdf
│   │   │   │   ├── notNicknameCheck.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── notNicknameCheck.pdf
│   │   │   │   └── profil.imageset
│   │   │   │       ├── Contents.json
│   │   │   │       └── profil.pdf
│   │   │   ├── SpudFace
│   │   │   │   ├── Contents.json
│   │   │   │   ├── angrySpud.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── angrySpud.pdf
│   │   │   │   ├── happySpud.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── happySpud.pdf
│   │   │   │   ├── inspirationSpud.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── inspirationSpud.pdf
│   │   │   │   ├── sadSpud.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── sadSpud.pdf
│   │   │   │   └── sensationSpud.imageset
│   │   │   │       ├── Contents.json
│   │   │   │       └── sensationSpud.pdf
│   │   │   ├── SpudImage
│   │   │   │   ├── Contents.json
│   │   │   │   ├── college.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── college.jpeg
│   │   │   │   ├── elementary.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── Elementary.jpeg
│   │   │   │   ├── employee.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── employee.jpeg
│   │   │   │   ├── high.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── high.jpeg
│   │   │   │   ├── kindergarden.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   └── kindergarden.jpeg
│   │   │   │   └── middle.imageset
│   │   │   │       ├── Contents.json
│   │   │   │       └── Middle.jpeg
│   │   │   └── TabImage
│   │   │       ├── Contents.json
│   │   │       ├── bookTap.imageset
│   │   │       │   ├── Contents.json
│   │   │       │   └── bookTap.png
│   │   │       ├── clickedBook.imageset
│   │   │       │   ├── Contents.json
│   │   │       │   └── clickedBook.pdf
│   │   │       ├── clickedHome.imageset
│   │   │       │   ├── Contents.json
│   │   │       │   └── clickedHome.pdf
│   │   │       ├── clickedISBN.imageset
│   │   │       │   ├── Contents.json
│   │   │       │   └── clickedISBN.pdf
│   │   │       ├── clickedReport.imageset
│   │   │       │   ├── Contents.json
│   │   │       │   └── clickedReport.pdf
│   │   │       ├── clickedSpud.imageset
│   │   │       │   ├── Contents.json
│   │   │       │   └── clickedSpud.png
│   │   │       ├── homeTab.imageset
│   │   │       │   ├── Contents.json
│   │   │       │   └── homeTab.pdf
│   │   │       ├── isbnTap.imageset
│   │   │       │   ├── Contents.json
│   │   │       │   └── isbnTap.pdf
│   │   │       ├── reportTab.imageset
│   │   │       │   ├── Contents.json
│   │   │       │   └── reportTab.pdf
│   │   │       └── spudTab.imageset
│   │   │           ├── Contents.json
│   │   │           └── spudTab.pdf
│   │   ├── BookSpudApp.swift
│   │   ├── Color.xcassets
│   │   │   ├── Background
│   │   │   │   ├── BackgrounYellow.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   └── Contents.json
│   │   │   ├── Contents.json
│   │   │   ├── Emotion
│   │   │   │   ├── AngryRed.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── Contents.json
│   │   │   │   ├── InspiredGreen.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── SadBlue.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── TouchedPurple.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   └── TouchedYellow.colorset
│   │   │   │       └── Contents.json
│   │   │   ├── Error
│   │   │   │   ├── Contents.json
│   │   │   │   ├── ErrorDark.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── ErrorDefault.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   └── ErrorLight.colorset
│   │   │   │       └── Contents.json
│   │   │   ├── Gray
│   │   │   │   ├── Contents.json
│   │   │   │   ├── Gray01.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── Gray02.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── Gray03.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── Gray04.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── Gray05.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── Gray06.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── Gray07.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   └── SubBtn.colorset
│   │   │   │       └── Contents.json
│   │   │   ├── Main
│   │   │   │   ├── Contents.json
│   │   │   │   ├── MainText.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── Primary1.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── PrimaryDark.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   └── SubText.colorset
│   │   │   │       └── Contents.json
│   │   │   ├── Success
│   │   │   │   ├── Contents.json
│   │   │   │   ├── SuccessDark.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── SuccessDefault.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   └── SuccessLight.colorset
│   │   │   │       └── Contents.json
│   │   │   └── Warning
│   │   │       ├── Contents.json
│   │   │       ├── WarningDark.colorset
│   │   │       │   └── Contents.json
│   │   │       ├── WarningDefault.colorset
│   │   │       │   └── Contents.json
│   │   │       └── WarningLight.colorset
│   │   │           └── Contents.json
│   │   ├── Icon.swift
│   │   ├── KeyboardHideExtension.swift
│   │   ├── OnBoardScreen.swift
│   │   ├── RoundedCorner.swift
│   │   ├── ShadowReuse.swift
│   │   └── UserState.swift
│   ├── ViewGroup
│   │   ├── BookTap
│   │   │   ├── BookEmotionKind.swift
│   │   │   ├── BookListCard
│   │   │   │   ├── BookListCardView.swift
│   │   │   │   ├── BookReadProgressView.swift
│   │   │   │   └── ReadingStatus.swift
│   │   │   ├── BookListDetailView
│   │   │   │   ├── BookCountComponent.swift
│   │   │   │   ├── BookListDetailView.swift
│   │   │   │   ├── PageUpdateView.swift
│   │   │   │   └── SeletedEmotionBtn.swift
│   │   │   ├── BookListView.swift
│   │   │   ├── BookMarkRegist
│   │   │   │   ├── BookMarkReadView.swift
│   │   │   │   ├── BookMarkRegistView.swift
│   │   │   │   ├── BookMarkTitleView.swift
│   │   │   │   └── OCR
│   │   │   │       ├── CameraView.swift
│   │   │   │       └── OCRView.swift
│   │   │   └── BookStatusBtn.swift
│   │   ├── HomeTap
│   │   │   ├── BookRecommend
│   │   │   │   ├── BookRecommendCardView
│   │   │   │   │   ├── BookRecommendCard.swift
│   │   │   │   │   └── BookRecommendCardViewModel.swift
│   │   │   │   ├── BookRecommendDetail
│   │   │   │   │   ├── BookRecommendDetailRow.swift
│   │   │   │   │   ├── BookRecommendDetailView.swift
│   │   │   │   │   ├── CheckingUserBookMarkView.swift
│   │   │   │   │   └── EmotionUserProfile.swift
│   │   │   │   └── BookRecommendView.swift
│   │   │   ├── EmotionGraph
│   │   │   │   ├── EmotionChartView.swift
│   │   │   │   └── NoRegistEmotion.swift
│   │   │   ├── EmotionVerses
│   │   │   │   ├── EmotionVersesView
│   │   │   │   │   ├── BookVersesView.swift
│   │   │   │   │   ├── EmotionPickerView.swift
│   │   │   │   │   └── SelectEmotionView.swift
│   │   │   │   └── EmotionVersesView.swift
│   │   │   ├── HomeView.swift
│   │   │   └── TopUserComponent.swift
│   │   ├── ISBNTap
│   │   │   ├── BarcodeScannerView.swift
│   │   │   ├── ISBNInputView
│   │   │   │   ├── ISBNCameraView.swift
│   │   │   │   └── ISBNManualView.swift
│   │   │   └── SuccessISBNView.swift
│   │   ├── ProfileSetting
│   │   │   ├── ProfileData.swift
│   │   │   └── ProfileSettingView.swift
│   │   ├── ReportTab
│   │   │   ├── DetailReport
│   │   │   │   ├── DetailReportA.swift
│   │   │   │   ├── DetailReportB.swift
│   │   │   │   └── ReadWriteText.swift
│   │   │   ├── ReportCard
│   │   │   │   ├── ReportCardView.swift
│   │   │   │   └── ReportTagComponent.swift
│   │   │   ├── ReportDraft
│   │   │   │   ├── CurrentPage.swift
│   │   │   │   └── ReportDraftView.swift
│   │   │   ├── ReportView.swift
│   │   │   └── SelectBookListView
│   │   │       ├── SelectBookListCard.swift
│   │   │       └── SelectedBookListView.swift
│   │   ├── SpudTab
│   │   │   ├── CharacterProgressView.swift
│   │   │   └── SpudView.swift
│   │   └── TapView
│   │       ├── BookSpudTab.swift
│   │       ├── BookSpudTabView.swift
│   │       ├── CustomTabView.swift
│   │       └── KeyboardObserver.swift
│   └── ViewModelGroup
│       ├── BookDetailViewModel.swift
│       ├── BookListViewModel.swift
│       ├── BookMarkDetailViewModel.swift
│       ├── BookMarkRegistViewModel.swift
│       ├── BookRecommendViewModel.swift
│       ├── CheckingUserBookMarkViewModel.swift
│       ├── DetailReportViewModel.swift
│       ├── EmotionChartViewModel.swift
│       ├── EmotionUserViewModel.swift
│       ├── EmotionVersesViewModel.swift
│       ├── ISBNInputViewModel.swift
│       ├── IndividualSelectBookViewModel.swift
│       ├── LoginViewModel.swift
│       ├── OCRViewModel.swift
│       ├── ProfileViewModel.swift
│       ├── ReportDraftViewModel.swift
│       ├── ReportViewModel.swift
│       ├── SelectBookListViewModel.swift
│       └── SpudViewModel.swift
└── BookSpud.xcodeproj
    ├── project.pbxproj
    ├── project.xcworkspace
    │   ├── contents.xcworkspacedata
    │   ├── xcshareddata
    │   │   ├── IDEWorkspaceChecks.plist
    │   │   └── swiftpm
    │   │       ├── Package.resolved
    │   │       └── configuration
    │   └── xcuserdata
    │       └── jeong-uichan.xcuserdatad
    │           ├── Bookmarks
    │           │   └── bookmarks.plist
    │           └── UserInterfaceState.xcuserstate
    └── xcuserdata
        └── jeong-uichan.xcuserdatad
            ├── xcdebugger
            │   └── Breakpoints_v2.xcbkptlist
            └── xcschemes
                └── xcschememanagement.plist

```


## 4. 역할
- **UI**
	- 로그인 뷰, 프로필 지정 뷰, 감정 피커 뷰, 북마크 랜덤 조회 및 상세 보기 뷰, 감정 차트 뷰, OCR ISBN 등록 뷰, 등록 책 전체 조회 뷰, 등록 책 상세 조회 뷰, 감정 북마크 조회 뷰, 감정 북마크 등록 뷰, OCR 텍스트 인식 뷰, 독후감 생성 뷰, 독후감 조회 뷰, 감자 성장 뷰
- **기능**
	-  위 UI에 사용되는 모든 뷰에 들어가는 기능 구현

&nbsp;


## 5. 개발 기간
- 전체 개발 기간 : 2024. 03. 03 - 2024. 06.14
- UI 디자인 : 2024. 03. 20 - 2024. 06. 05
- 기능 및 UI 개발 : 2024. 04. 26 - 2024. 06. 04

&nbsp;
## 6. 앱 성능 테스트
<img width="1100" alt="스크린샷 2024-06-14 오후 7 12 47" src="https://github.com/24-2-CapstoneDesign/Front_iOS/assets/80624315/78ab1119-b57a-4f07-abb4-b79c6b877b4d">
앱의 상태 관리와 이미지, API 데이터 관리를 효율적으로 구현하기 위해 다양한 전략을 도입했다. 이러한 전략들은 앱의 성능 최적화 및 자원 관리를 돕기 위해 설계되었으며, 그 결과를 성능 분석 도구를 통해 확인했다.

- **메모리 사용량**
	- 평균 메모리 사용량 : 139 MB
	- 최대 메모리 사용량 : 206.5 MB
- **메모리 사용 그래프**
	- 그래프를 통해 메모리 사용량이 일정하게 유지되는 것을 확인할 수 있다.
	- 일시적인 스파이크가 발생했지만, 이는 이미지 로딩이나 API 호출과 같은 이벤트와 일치하며 이후 안정적으로 유지되었다.
- **메모리 사용 비율**
	- 앱은 전체 시스템 메모리의 약 1.8%를 사용하고 있다.
	- 다른 프로세스와 비교하여, 적절한 메모리 사용률을 보이고 있다.
- **앱 사용 비율**
	- Book Spud 앱이 차지하는 메모리 : 139.5 MB
	- 다른 프로세스 사용 메모리 : 4.81 GB
	- 남은 자유 메모리 : 2.5 GB

- 효율적인 메모리 관리
	- 앱의 메모리 사용량이 일정하게 유지되며, 과도한 메모리 사용 없이 효율적으로 관리되고 있음을 확인했다.
- 일시적 스파이크 관리
	- 일시적인 메모리 사용 스파이크가 발생하였으나, 이는 일시적 이벤트와 관련된 것으로 보이며 이후 안정적으로 관리되었다.
- 적절한 시스템 자원 사용
	- 전체 시스템 메모리 사용률에 비해 적절한 수준의 메모리 사용을 보여, 다른 앱들과의 자원 경합에서 큰 문제가 발생하지 않음을 알 수 있다.


&nbsp;

### 7. 프로젝트 후기
대량의 이미지를 효율적으로 처리하고, 이를 바탕으로 앱의 상태 관리와 OCR 판독 기능을 구현하는 데 집중했다. 다양한 기술과 전략을 응용하여 앱의 성능을 최적화하고자 했다.

- **멀티 파트 폼을 통한 이미지 업로드**
	- 사용자가 대량의 이미지를 업로드하는 상황을 지원하기 위해 멀티 파트 폼을 도입
	- 이 방식은 한 번에 여러 이미지를 전송할 수 있어 사용자 편의성 크게 향상
- **구현 및 성능 최적화**
	- 이미지 업로드 시 네트워크 부하를 최소화하기 위해 비동기 처리와 병렬 업로드 방식 사용
	- 각 이미지 업로드 완료 후 캐싱 처리하여 동일 이미지의 반복 요청을 줄이고, 서버 부하를 감소
- **이미지 캐싱 처리**
	- 자주 사용되는 이미지는 로컬 캐시에 데이터 타입으로 저장하여 불필요한 네트워크 요청을 줄였다.
	- 캐시 만료 정책을 설정하여 일정 시간 후 자동으로 캐시를 갱신하도록 함
- **효과 및 결과**
	- 이미지 로딩 속도가 크게 향상되어 사용자 경험이 개선
	- 네트워크 트래픽 감소로 서버의 안정성과 성능이 향상
- **앱의 상태 관리**
	- 비동기 액션을 통해 이미지 업로드와 OCR 판독 작업을 처리하고 작업 완료 후 상태를 갱신하였다.
	- 메모리 사용량을 모니터링하고, 불필요한 상태나 데이터를 정리하여 메모리 누수 방지
- **효과 및 결과**
	- 사용자들이 이미지 속 텍스트를 손쉽게 추출하고 활용할 수 있어, 독서 기록과 메모 작성이 더욱 편리해졌다. 또한 앱에 책을 등록하는 데 있어 책의 바코드를 인식 시켜 빠르게 등록할 수 있다.

&nbsp;
### 8. 종합 평가
이번 프로젝트를 통해 멀티 파트 폼을 활용한 이미지 업로드, 캐싱 처리, 앱의 상태 관리, OCR 판독 기능을 효과적으로 구현할 수 있었다. 다양한 최적화 전략과 기술 도입을 통해 사용자 경험을 크게 향상 시킬 수 있었으며, 시스템의 안정성과 성능을 높일 수 있었다. 앞으로도 지속적인 개선과 최적화를 통해 더 나은 서비스를 제공할 수 있도록 노력할 것이다.