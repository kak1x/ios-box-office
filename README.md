# 박스오피스 🎬

> **소개: 영화진흥위원회 오픈 API(일별 박스오피스 조회), 카카오 이미지 검색 API(영화 포스터 이미지 검색)를 사용하여 영화 정보를 조회할 수 있는 앱이다. 화면 모드를 선택하여 박스오피스 조회 화면의 형태를 바꿔줄 수 있으며, URLCache와 NSCache를 사용하여 빠르게 정보 조회를 할 수 있는 기능도 구현되어있다.**


</br>

## 목차
1. [팀원](#1-팀원)
2. [타임라인](#2-타임라인)
3. [프로젝트 구조](#3-프로젝트-구조)
4. [실행화면](#4-실행-화면)
5. [트러블슈팅](#5-트러블-슈팅)
6. [팀회고](#6-팀회고)
7. [참고링크](#7-참고-링크)

<br>

## 1. 팀원

|[Harry](https://github.com/HarryHyeon)| [kaki](https://github.com/kak1x) |
| :--------: | :--------: |
|<img height="180px" src="https://i.imgur.com/BYdaDjU.png">| <img height="180px" src="https://i.imgur.com/KkFB7j3.png"> |

<br>

## 2. 타임라인
#### 프로젝트 진행 기간 : 23.03.20 (월) ~ 23.04.14 (금)

<details>
    <summary><big>타임라인</big></big></summary>

| 날짜 | 타임라인 |
| --- | --- |
|23.03.20 (월)| 박스오피스 모델 타입, 영화 상세정보 모델 타입 구현, 모델 테스트 |
|23.03.21 (화)| 원격 서버와 Http 통신을 위한 NetworkManager 타입 구현 |
|23.03.22 (수)| Endpoint를 생성가능한 BoxOfficeEndpoint 구현 |
|23.03.23 (목)| NetworkManager 테스트(MockURLSession, MockURLSessionDataTask 활용) |
|23.03.24 (금)| 코드 컨벤션 수정, Pull Request 컨플릭 해결, README 작성, CollectionView CompositionalLayout / Identifying 프로토콜 구현 |
|23.03.27 (월)| JSON 모델 분리 및 사용하지 않는 프로퍼티 삭제, CollectionViewListCell / Activity Indicator / Refresh Control 구현 |
|23.03.28 (화)| CollectionViewListCell 오토레이아웃 수정 및 셀 데이터 할당 기능 구현 |
|23.03.29 (수)| URLRequest 요청으로 로직 변경, MovieInfoViewController / ScrollView / 포스터 이미지 및 영화 상세정보 fetch 기능 구현 |
|23.03.30 (목)| 코드 컨벤션 수정, DataFormatter 타입 프로퍼티 사용으로 변경 |
|23.03.31 (금)| 사용 API 변경 (네이버 영화 -> 카카오 이미지), MovieInfoViewController 오토레이아웃 수정, Activity Indicator 구현 |
|23.04.03 (월)| UICalendarView를 활용한 CalendarViewController 구현 |
|23.04.04 (화)| CompositionalLayout을 이용해 새로운 CustomLayout 생성 및 이를 위한 BoxOfficeCollectionViewCell 구현 |
|23.04.05 (수)| 코드 컨벤션 수정, ViewController 기능 분리, NetworkManagerTest에 Mock을 활용한 행위 검증 테스트케이스 추가 |
|23.04.06 (목)| Step4에서 변경했던 사항들 Git Conflict 해결하여 박스오피스2 Step1, Step2에 Merge |
|23.04.07 (금)| README 작성, Date extension 구현하여 어제 날짜 구현부 대체, ToolBar, ActionSheet 및 화면 전환 기능(레이아웃 및 셀 타입 변경) 구현 |
|23.04.08 (토)| 불필요한 self 바인딩 제거 |
|23.04.09 (일)| 화면 전환 방식 수정(CollectionView 2개를 이용하여 서로 전환해주는 방식으로 변경) |
|23.04.10 (월)| 2개의 CollectionView 전환간 애니메이션 기능 추가 구현, RefreshControl 오류 해결, Dynamic Type 적용 |
|23.04.11 (화)| URLCache 정책 수립 및 URLCache 기능 추가 |
|23.04.12 (수)| 코드 컨벤션 수정, AlertFactory Pattern 적용, ImageCache 기능 추가 |
|23.04.13 (목)| 화면 전환 방식 수정(한 개의 CollectionView에서 기본 애니메이션 없이 레이아웃 변경해주는 방식 적용, Custom으로 구현한 애니메이션 적용) |
|23.04.14 (금)| README 작성 |

</details>

<br>

## 3. 프로젝트 구조

<details>
    <summary><big>폴더 구조</big></big></summary>

``` swift
BoxOffice
    ├── Model
    |    ├── Network
    |    │    ├── NetworkManager
    |    │    ├── NetworkError
    |    │    ├── BoxOfficeEndpoint
    |    │    ├── URLSessionProtocol
    |    │    ├── URLSessionDataTaskProtocol
    |    │    ├── URLCacheManager
    |    │    └── ImageCacheManager
    |    └── JSONModel
    |         ├── BoxOffice
    |         │    ├── BoxOffice
    |         │    ├── BoxOfficeResult
    |         │    ├── DailyBoxOffice
    |         │    └── RankOldAndNew
    |         │── Movie
    |         │    ├── Movie
    |         │    ├── MovieInfoResult
    |         │    ├── MovieInfo
    |         │    ├── Actor
    |         │    ├── Audit
    |         │    ├── Director
    |         │    ├── Genre
    |         │    └── Nation
    |         └── MoviePoster
    |              └── MoviePoster
    ├── View
    |    ├── Main
    |    ├── LaunchScreen
    |    ├── BoxOfficeCollectionViewListCell.xib
    |    ├── BoxOfficeCollectionViewCell.xib
    |    ├── BoxOfficeCollectionViewListCell.swift
    |    ├── BoxOfficeCollectionViewCell.swift
    |    ├── BoxOfficeViewController
    |    ├── MovieInfoViewController
    |    └── CalendarViewController
    ├── Controller
    |    ├── BoxOfficeDataLoader
    |    └── MovieInfoDataLoader
    ├── Etc
    |    ├── AlertFactory
    |    │    ├── AlertFactoryService
    |    │    ├── AlertImplementation
    |    │    └── AlertViewData
    |    ├── AppDelegate
    |    ├── SceneDelegate
    |    ├── Identifying
    |    ├── Array+Subscript
    |    ├── String+DecimalFormatter
    |    ├── DateFormmatter+HyphenFormat
    |    ├── Date+previousDate
    |    ├── CellConfigurable
    |    └── UICollectionView+Animate
    ├── Assets
    ├── Info
    └── UnitTests
         ├── BoxOfficeTests
         │    └── BoxOfficeTests
         ├── MovieTests
         │    └── BoxOfficeTests
         └── NetworkManagerTests
              ├── NetworkManagerTests
              ├── SampleData
              └── Mocks
                   ├── MockURLSessionDataTask
                   └── MockURLSession
```

</details>

</br>

## 4. 실행 화면

|**박스오피스 조회 화면**|**화면 정보 새로 고침**|**영화 상세 정보 페이지 이동**|
|:-----:|:-----:|:-----:|
| <img src = "https://user-images.githubusercontent.com/51234397/229131236-f60a5e28-51d2-4cb5-b404-8b7c05d00fdc.gif" width = "300">|<img src = "https://user-images.githubusercontent.com/51234397/229131247-ddb94683-f139-41a3-956d-7547e165fee4.gif" width = "300"> |<img src = "https://user-images.githubusercontent.com/51234397/229131249-fb7f5665-9f3f-4dc2-94f4-992a40f2ee35.gif" width = "300">|
|**박스오피스 조회 화면 모드 변경**|**박스오피스 조회 화면 URLCache**|**영화 상세 정보 ImageCache, URLCache**|
| <img src = "https://user-images.githubusercontent.com/51234397/231964204-4589740d-2ecb-433c-a479-a6285d57a421.gif" width = "300">|<img src = "https://user-images.githubusercontent.com/51234397/231964220-817b7d68-dd49-4cfc-800a-ff0c420d1d0b.gif" width = "300"> |<img src = "https://user-images.githubusercontent.com/51234397/231964233-ab8c55bd-76fe-4b0f-bc9d-52b6af6add13.gif" width = "300">|

<br>

## 5. 트러블 슈팅

### 1️⃣ Model의 UnitTest

```swift
extension DailyBoxOfficeList: Equatable {
    public static func == (lhs: DailyBoxOfficeList, rhs: DailyBoxOfficeList) -> Bool {
        return lhs.number == rhs.number
        && lhs.rank == rhs.rank
        && lhs.rankIncrement == rhs.rankIncrement
        && lhs.rankOldAndNew == rhs.rankOldAndNew
        && lhs.movieCode == rhs.movieCode
        && lhs.movieKoreanName == rhs.movieKoreanName
        && lhs.openDate == rhs.openDate
        && lhs.salesAmount == rhs.salesAmount
        && lhs.salesShare == rhs.salesShare
        && lhs.salesIncrement == rhs.salesIncrement
        && lhs.salesChange == rhs.salesChange
        && lhs.salesAccumulation == rhs.salesAccumulation
        && lhs.audienceCount == rhs.audienceCount
        && lhs.audienceIncrement == rhs.audienceIncrement
        && lhs.audienceChange == rhs.audienceChange
        && lhs.audienceAccumulation == rhs.audienceAccumulation
        && lhs.screenCount == rhs.screenCount
        && lhs.showCount == rhs.showCount
    }
}
```

- 모델의 유닛 테스트를 위해 Equatable 채택을 하여 모델의 모든 값이 맞는지 확인하였습니다.
- 그러나 위 방식은 휴먼에러가 발생할 위험성이 높다고 생각되어 다른 방법을 고민하였습니다.
- 모델의 검증하는 방법 중에 서버에서 고유한 아이디 값을 내려주거나 `identifiable` 프로토콜을 채택하여 해당 모델이 고유한 id를 가질 수 있도록하여 검증하는 방법이 있습니다.
- 현재 프로젝트에서는 서버에서 값을 내려줄 수 없기 때문에 몇 가지 프로퍼티가 맞는지 확인하는 방법을 사용하기로 했습니다.

### ⚒️ 해결방법
``` swift
func test_두번째_dailyBoxOffice의_number값이_문자열2이다() {
    // given
    let expectedResult = "2"
     
    // when
    let boxOfficeNumber = sut.boxOfficeResult.dailyBoxOfficeList[1].numberText
        
    // then
    XCTAssertEqual(expectedResult, boxOfficeNumber)
    }
```
- 따라서 테스트 할 때를 제외하고 필요없는 코드라고 판단되어 Equatable 채택을 제거하고 특정 프로퍼티 몇 개를 체크하는 방식으로 변경하였습니다.

<br>

### 2️⃣ ErrorDescription 사용
```swift
enum NetworkError: LocalizedError {
    case urlError
    case invalidResponseError
    case invalidHttpStatusCode(Int)
    case emptyData
    case decodeError
    
    var errorDescription: String {
        switch self {
        case .urlError:
            return "잘못된 URL입니다."
        case .invalidResponseError:
            return "알 수 없는 응답 에러입니다."
        case .invalidHttpStatusCode(let code):
            return "status: \(code)"
        case .emptyData:
            return "데이터가 비어있습니다."
        case .decodeError:
            return "decodeError가 발생했습니다."
        }
    }
}
```
- NetworkError 타입이 LocalizedError를 채택하도록 하고, API 호출을 요청하는 쪽에서 error를 수신하게 될때 `error.localizedDescription`를 통해 위에 정의한 문자열을 반환하도록 처리하기 위해 `errorDescription` 연산 프로퍼티를 구현해주었습니다.
- 하지만 `error.localizedDescription`를 사용할시 정의한 문자열이 반환되지 않는 오류가 발생하였습니다.

### ⚒️ 해결방법
```swift
var errorDescription: String? {
    switch self {
    case .urlError:
        return "잘못된 URL입니다."
    case .invalidResponseError:
        return "알 수 없는 응답 에러입니다."
    case .invalidHttpStatusCode(let code):
        return "status: \(code)"
    case .emptyData:
        return "데이터가 비어있습니다."
    case .decodeError:
        return "decodeError가 발생했습니다."
    }
}
```
- `errorDescription: String?`과 `errorDescription: String`는 다른 프로퍼티이기 때문에 override가 제대로 되지 않아 발생한 문제였습니다.
- `erorDescription`의 타입을 String?으로 변경해주니 정상적으로 작동하게 되었습니다.
- LocalizedError 프로토콜이 Error를 상속받기 때문에 Result의 실패 타입이 Error여도 정의한 문자열이 잘 출력되는 것을 확인할 수 있었습니다.

<br>

### 3️⃣ Endpoint를 관리하는 타입
```swift
struct BoxOfficeURLManager {
...
    
    func makeBoxOfficeURL(targetDate: String) -> URL? {
        
        var components = URLComponents()
        ...
        return components.url
    }
    
    func makeMovieInfoURL(movieCode: String) -> URL? {
        var components = URLComponents()
        ...
        return components.url
    }
}

```

- 박스오피스 프로젝트에서는 2가지 api를 사용합니다.
    - 일별 박스오피스 순위 조회
    - 영화 상세정보 조회
- 2가지 api의 url을 쿼리를 통해 정보를 가져와야 하기 때문에 Endpoint를 관리하고 url을 생성해주는 타입이 필요하다고 생각했습니다.
- 박스오피스 순위 조회를 위한 url, 영화 상세정보 보기를 위한 url을 각각 다른 메서드를 사용해서 url을 만들어 주는 방식을 사용하고 있었습니다.



### ⚒️ 해결방법

``` swift
enum BoxOfficeEndpoint {
    case fetchDailyBoxOffice(targetDate: String)
    case fetchMovieInfo(movieCode: String)
}

extension BoxOfficeEndpoint {
    var path: String {
        switch self {
        case .fetchDailyBoxOffice:
            return "..."
        case .fetchMovieInfo:
            return "..."
        }
    }
    
    var queries: [URLQueryItem] {
        switch self {
        case .fetchDailyBoxOffice(let targetDate):
            return [ ... ]
        case .fetchMovieInfo(let movieCode):
            return [ ... ]
        }
    }
    
    func createURL() -> URL? {
        var components = URLComponents(string: baseURL)
        components?.path = path
        components?.queryItems = queries
        
        return components?.url
    }
}
```
- enum 타입으로 정의하여 2가지 조회 방법이 필요하게되는 경우를 각각 case로 지정하고 switch문을 사용하여 case에 따라 경로와 쿼리가 달라지도록 하여 URLRequest을 생성해 주는 방식으로 변경하였습니다.

<br>

### 4️⃣ 컬렉션뷰 셀에 accessory 뷰 추가하기
<img src="https://i.imgur.com/8z4N5m7.png" width="300">

- UICollectionViewCell은 accessories를 달기위해서 따로 이미지뷰를 활용해 직접 레이아웃을 설정해주어야 합니다.


### ⚒️ 해결방법
``` swift
private func createListLayout() -> UICollectionViewCompositionalLayout {
    var config = UICollectionLayoutListConfiguration(appearance: .plain)
        
    return UICollectionViewCompositionalLayout.list(using: config)
}
```

-  기본으로 제공하는 UICollectionLayoutListConfiguration을 사용하기 위해 재사용하는 셀의 타입도 UICollectionViewListCell로 설정해 주었습니다.

``` swift
final class BoxOfficeCollectionViewListCell: UICollectionViewListCell {    
    override func awakeFromNib() {
    super.awakeFromNib()

    self.accessories = [
        .disclosureIndicator()
    ]
}
```
- UICollectionViewListCell에서 accesories 프로퍼티를 활용해 추가해주고 싶은 accessory를 추가해줄 수 있습니다.

<br>

### 5️⃣ Separator Inset
<img src="https://i.imgur.com/0tKZ0Nf.png" width="300">

- 처음엔 ListCell의 Separator Inset을 조절해주기 위해 `updateConstraints` 메서드를 사용해주었습니다.
```swift
// BoxOfficeCollectionViewListCell

override func updateConstraints() {
    super.updateConstraints()
    
    separatorLayoutGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
}
```
- 이를 통해 Separator Inset을 조절해줄 수 있었지만, 다음과 같은 에러를 발생시켰습니다.

<img src="https://i.imgur.com/t9fnQ76.png" width="500">

### ⚒️ 해결방법
- `separatorConfiguration.bottomSeparatorInsets` 프로퍼티를 사용하는 것으로 방법을 변경해주었고 이를 사용하기 위해 프로젝트의 버전을 14.5로 올려주게 되었습니다.
```swift
// BoxOfficeViewController

private func createListLayout() -> UICollectionViewCompositionalLayout {
    var config = UICollectionLayoutListConfiguration(appearance: .plain)
    config.separatorConfiguration.bottomSeparatorInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    return UICollectionViewCompositionalLayout.list(using: config)
}
```

<br>

### 6️⃣ 영화 포스터 이미지와 영화 정보 레이블 동시에 표시하기
- 영화 상세정보(영화진흥위원회 API), 영화 포스터 이미지(카카오 이미지 API) 불러오기 2가지 작업이 각각 비동기로 작업이 진행됩니다.
- 둘 중 특정 한가지 작업이 끝났을 때, Activity Indicator의 애니메이션을 종료시키는 것이 적절치 못하다고 생각했습니다.


### ⚒️ 해결방법 1

``` swift
fetchMovieInfo(completion: checkFetchComplete)
fetchMoviePosterImage(completion: checkFetchComplete)
```

``` swift
private func fetchMovieInfo(completion: @escaping () -> ()) {
    guard let movieCode = movieCode else { return }

    let endPoint: BoxOfficeEndPoint = .fetchMovieInfo(movieCode: movieCode)

    networkManager.fetchData(request: endPoint.createRequest(), type: Movie.self) {
        [weak self] result in
        guard let self = self else { return }

        switch result {
        case .success(let data):
            self.movieInfo = data
        case .failure(let error):
            print(error.localizedDescription)
            self.showFailAlert(error: error)
        }
        completion()
    }
}
```
- fetchMovieInfo(상세정보 불러오기)와 fetchMovieFoster(영화포스터 이미지 불러오기) 메서드에 completion 핸들러를 추가하여 각각 completion이 실행될 때마다 데이터가 존재하는지 검사하는 로직을 추가했습니다. 

```swift
private var movieInfo: Movie?
private var posterImage: UIImage?

private func checkFetchComplete() {
    guard posterImage != nil && movieInfo != nil,
          let movieInfo = movieInfo else { return }
    
    DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        
        self.activityIndicator.stopAnimating()
        self.posterImageView.image = self.posterImage
        self.configureLabels(data: movieInfo)
        self.contentStackView.isHidden = false
    }
}
```
- fetchMovieInfo, fetchMoviePoster 메서드를 통해 데이터를 모두 받았는지 확인하고
- 2가지 작업이 모두 끝났을 때, Activity Indicator의 애니메이션을 중지시키고 화면에 이미지와 정보를 동시에 표시할 수 있도록 구현하였습니다.

### ⚒️ 해결방법 2
- 해결방법 1에서 checkFetchComplete라는 함수를 (박스오피스순위 조회, 영화 포스터 가져오기) 두 가지 작업의 컴플리션으로 사용하여 체크하는 방식을 사용했습니다.
- 하지만 이 방법에서의 문제점이 오로지 체크를 하기위한 용도의 프로퍼티들을 뷰컨트롤러에서 가져야 한다는 것이고, 뷰 컨트롤러에서 이런 체크를 하는 로직을 따로 수행을 해야해서 뷰 컨트롤러에 기능이 집중되어 있다고 생각했습니다.

``` swift
// MovieInfoViewController.swift

private func loadData() {
    let group = DispatchGroup()

    activityIndicator.startAnimating()
    group.enter()
    movieInfoDataLoader.loadMovieInfo(movieCode: movieCode) { result in
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let data):
                self?.configureLabels(data: data)
                group.leave()
            case .failure(let error):
                self?.showFailAlert(error: error)
                group.leave()
            }
        }
    }
    
    group.notify(queue: .main) { [weak self] in
            self?.showMovieInfo()
    }
}
```
- DispatchGroup을 활용해서 비동기적으로 발생하는 두 가지 작업을 `group.notify(queue:)` 메서드를 활용해 동시에 뷰에 나타날 수 있도록 수정해주었습니다.
- 이렇게 수정한 결과 뷰 컨트롤러에서 서버와 통신을해 데이터를 받고, 받아온 데이터를 처리하고 다시 이미지를 로드하고 하는 일련의 과정들을 다른 타입에서 관리할 수 있게 되었습니다. 
- 또, 뷰 컨트롤러에서는 데이터가 정상적으로 받아졌는지 확인하는 용도의 프로퍼티가 불필요하게 되었고 코드를 보았을 때 어떤 작업을 하는 것인지 알기가 조금 쉬워졌다고 생각합니다.
- 따라서 `해결방법 2`를 채택하여 구현하였습니다.

### 7️⃣ 뷰 컨트롤러의 데이터 관련 기능 추상화
- `6️⃣의 해결방법 2`를 통해 뷰 컨트롤러의 기능 분리가 제대로 되지 못했다고 느꼈고, 더욱이 뷰 컨트롤러에서 데이터를 가져오는 역할까지 한다는 것도 뷰 컨트롤러에 너무 많은 기능이 집중되어 있다고 생각했습니다.

### ⚒️ 해결방법

``` swift
// MovieInfoDataLoader.swift

func loadMovieInfo(movieCode: String?, completion: @escaping (Result<Movie, Error>) -> ()) {
guard let movieCode = movieCode else { return }

let endPoint: BoxOfficeEndpoint = .fetchMovieInfo(movieCode: movieCode)

networkManager.fetchData(request: endPoint.createRequest(), type: Movie.self) {
    result in
    switch result {
    case .success(let data):
        completion(.success(data))
    case .failure(let error):
        completion(.failure(error))
    }
}
```
- 뷰 컨트롤러에서 서버와 통신하고 데이터를 처리하는 기능을 새로운 타입으로 분리시켜 주었습니다.
- 뷰 컨트롤러에서는 뷰를 업데이트를 하는 작업에 대한 코드만 클로져를 통해 넘겨주며, 작업이 끝나는지 체크하는 방법은 `6️⃣의 해결방법 2`를 사용하여 역할 분리를 해줄 수 있었습니다.

<br>

### 8️⃣ Mock을 활용한 Network Model Test
- 아래의 코드는 미리 샘플 데이터를 MockURLSession에 준비해두고, fetchData() 메서드가 성공한다는 가정하에 fetchData 메서드의 컴플리션 핸들러로 내려오는 결과가 샘플 데이터와 일치하느냐를 검사하는 테스트입니다.

``` swift
func test_fetchData_호출시_BoxOffice_sample_data_불러오기에_성공한다() {
    // given
    let expectedResult = try? JSONDecoder().decode(BoxOffice.self, from: SampleData.boxOfficeData!)
    let request = BoxOfficeEndpoint.fetchDailyBoxOffice(targetDate: "20120101").createRequest()

    // when, then
    sut.fetchData(request: request, type: BoxOffice.self) { result in
        switch result {
        case .success(let data):
            XCTAssertEqual(expectedResult?.boxOfficeResult.type, data.boxOfficeResult.type)
        case .failure:
            XCTFail()
        }
    }
}
```
- 위와 같은 형식의 테스트는 단순히 결과 값에 대한 상태를 검증하는 Stub 테스트라는 생각을 했고, Mock 객체를 사용하는 용도를 다시 생각해보았을 때 fetchData라는 행위를 검증하기 위해서는 fetchData의 호출로 인해 개발자가 설계한 행위들이 정상적으로 동작하는지를 검증해야한다고 생각했습니다.


### ⚒️ 해결방법

```swift
class MockURLSession: URLSessionProtocol {
    ...
    var request: URLRequest!
    var dataTaskCallCount = 0
    
    ...
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        self.request = request
        self.dataTaskCallCount += 1
        
        ...
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    ...
    var resumeCallCount = 0
    
    func resume() {
        self.resumeCallCount += 1
        resumeDidCall?()
    }
}
```
- 위와 같이 `request`, `dataTaskCallCount`, `resumeCallCount`를 추가해 주었습니다.
- 테스트하고자하는 타입은 NetworkManager로 주요 기능으로는 fetchData가 있고, fetchData가 하는 기능은 dataTask 메소드를 호출하고 dataTask를 resume 하는 일입니다. 
- 따라서 새롭게 선언한 프로퍼티들을 활용해 MockURLSession 객체안에 request가 잘 전달이 되었는지, dataTask는 한번 호출된 것이 맞는지, resume() 메서드가 한번 호출된 것이 맞는지를 확인할 필요가 있다고 생각했습니다.

```swift
func test_fetchData_호출에_넘겨준_request와_session의_request가_동일하다() {
    // given
    let request = BoxOfficeEndpoint.fetchDailyBoxOffice(targetDate: "20120101").createRequest()
    
    // when
    let session = MockURLSession()
    sut = .init(session: session)
    sut.fetchData(request: request, type: BoxOffice.self) { _ in return }
    
    // then
    XCTAssertEqual(request, session.request)
}

func test_fetchData_호출시_session의_dataTask는_1번_호출된다() {
    ...
    XCTAssertEqual(1, session.dataTaskCallCount)
}

func test_fetchData_호출시_sessionDataTask의_resume이_1번_호출된다() {
    ...
    XCTAssertEqual(1, session.sessionDataTask.resumeCallCount)
}
```

<br>

### 9️⃣ Icon 모양의 셀에 Dynamic Type 적용 문제
<img src="https://i.imgur.com/Wz7f0eA.png" width="200">

- Icon 모양의 셀에서 Acessbility Inspector로 텍스트 크기를 키우게되면 위와 같은 모습으로 짤리거나 특정 레이블은 표시가 되지 않는 문제가 발생했습니다.
- 일단은 작은 크기의 셀에 너무 많은 정보를 담고 있다고 생각이 들었고, 처음 생각한 해결방법은 각각의 셀마다 컨텐츠에따라 높이를 다르게 주는것을 고려했습니다.
- 하지만 각각의 셀마다 다른 높이를 주게되면 어색한 모양으로 정보의 전달이 잘 안될 것이라는 생각이 들었습니다.

### ⚒️ 해결방법
``` swift
NotificationCenter.default.addObserver(self,
                                       selector: #selector(simplifyItems),
                                       name: UIContentSizeCategory.didChangeNotification,
                                       object: nil)

@objc private func simplifyItems() {
    if traitCollection.preferredContentSizeCategory >= UIContentSizeCategory.extraExtraLarge {
        rankInfoLabel.isHidden = true
        audienceInfoLabel.isHidden = true
    } else {
        rankInfoLabel.isHidden = false
        audienceInfoLabel.isHidden = false
    }
}
```
- 셀에서 가장 필요한 정보는 순위와 제목이라고 생각을 했습니다.
- `UIContentSizeCategory.didChangeNotification`의 이벤트를 수신해 컨텐츠사이즈 카테고리를 검사하여 `UIContentSizeCategory.extraExtraLarge` 크기 이상일때 순위와 제목외의 레이블은 Hidden 처리해주었습니다.

<img src="https://i.imgur.com/19hjHBq.png" width="200">

<br>

### 🔟 Alert이 필요할때마다 AlertController를 매번 정의해주던 문제
``` swift
extension UIViewController {
    func showIconModeSheet(completion: @escaping (UIAlertAction) -> ()) {
        let actionSheet = UIAlertController(title: "화면모드변경",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "아이콘", style: .default, handler: completion))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(actionSheet, animated: true)
    }
    ...
}

```
- 위와 같은 방식으로 extension을 활용해 필요한 Alert이 있을때마다 새롭게 extension에 추가해 주어야했습니다.
- 또한, 반복적인 코드가 많이 작성해야하는 비효율적인 방식이라는 생각이들었습니다.

### ⚒️ 해결방법: Factory 패턴 사용하기

#### AlertFactoryService
``` swift
protocol AlertFactoryService {
    func makeAlert(alertData: AlertViewData) -> UIAlertController
}

```
- 프로토콜을 활용해 AlertController를 생성해주는 메서드를 정의했습니다.

#### AlertViewData 정의
``` swift
struct AlertViewData {
    let title: String
    let message: String?
    let style: UIAlertController.Style
    let enableOkAction: Bool
    let okActionTitle: String
    let okActionStyle: UIAlertAction.Style
    let enableCancelAction: Bool
    let cancelActionTitle: String?
    let cancelActionStyle: UIAlertAction.Style
    let completion: (() -> ())?
}
```
- AlertController를 생성할때 필요한 정보를 주입할 수 있도록 AlertViewData 타입을 생성해 주었습니다.

#### AlertImplementation 정의
``` swift
final class AlertImplementation: AlertFactoryService {
    
    func makeAlert(alertData: AlertViewData) -> UIAlertController {
        let alertController = UIAlertController(title: alertData.title,
                                                message: alertData.message,
                                                preferredStyle: alertData.style)
        
        if alertData.enableOkAction {
            let okAction = UIAlertAction(
                title: alertData.okActionTitle,
                style: alertData.okActionStyle) { _ in
                    alertData.completion?()
                }
            alertController.addAction(okAction)
        }
        
        ...
        
        return alertController
    }
}
```
- AlertFactoryService을 채택하고 있는 `AlertImplementation`을 정의하여 makeAlert() 메서드의 동작을 정의했습니다.
- AlertViewData의 정보를 통해 AlertController의 제목, 메세지, 스타일, 컴플리션핸들러 등을 지정하고 AlertController 객체를 반환하도록 해주었습니다.

#### 사용
``` swift
@IBAction private func switchLayoutModeTapped() {
    let alertData = AlertViewData(title: "화면모드 변경",
                                  message: nil,
                                  style: .actionSheet,
                                  enableOkAction: true,
                                  okActionTitle: layoutMode.actionTitle,
                                  okActionStyle: .default,
                                  enableCancelAction: true,
                                  completion: changeLayout)
    let actionSheet = alertFactory.makeAlert(alertData: alertData)

    present(actionSheet, animated: true)
}
```
- Alert이가 필요할때마다 매번 AlertController의 생성을 정의할 필요없이 AlertViewData를 작성해서 makeAlert(alertData:) 메서드에 주입시켜주면 간단하게 사용할 수 있었습니다.

<br>

### 1️⃣1️⃣ 화면 모드 변경(리스트, 아이콘)에서 발생하는 Constraints 에러, 부자연스러운 모드변경

<img src="https://user-images.githubusercontent.com/51234397/231966484-f396e3c1-8e1b-4950-8914-583e76c4a640.gif" width="200">

- 처음엔 `collectionView.setCollectionViewLayout(layout:_, animated: true)` 메서드를 사용하여 레이아웃을 변경해주며, BoxOfficeViewController에 정의된 `LayoutMode`에 따라 일치하는 셀의 타입을 반환해주는 방식을 사용했습니다.
- 하지만 리스트 모드에서 아이콘 모드로 변경될 시, 레이아웃이 변경되기 전에 `reloadData()`를 해주는 과정에서 아이콘 모드의 Cell이 리스트 레이아웃에서 처리할 수 있는 Cell의 크기보다 커 발생한 오류로 인한 레이아웃 에러가 콘솔창에 출력되었습니다.
- 그리고 레이아웃과 셀을 동시에 변경할 수 없기에 화면 모드 변경 시 작동되는 애니메이션이 부자연스러운 모습을 보여주었습니다.

### ⚒️ 해결방법 1 - 2개의 CollectionView 사용
- 이에 대한 해결 방법으로 각각의 화면 모드에 따른 CollectionView를 따로 구현해주고, 불필요한 CollectionView를 Hidden 해주는 방식을 사용했습니다.
``` swift
extension UICollectionView {
    func fadeIn(_ duration: TimeInterval = 0.4) {
        self.alpha = 0
        self.isHidden = false
        UICollectionView.animate(withDuration: duration) { [weak self] in
            self?.alpha = 1
        }
    }
    
    func fadeOut(_ duration: TimeInterval = 0.4) {
        UICollectionView.animate(withDuration: duration) { [weak self] in
            self?.alpha = 0
        }
    }
}
```

- Hidden을 해주고 Hidden을 제거해주는 과정에 위와 같이 `UICollcectionView.animate`를 따로 정의해주어 전환간에 애니메이션 효과를 주었습니다.
- 하지만 같은 데이터를 2개의 CollectionView가 항상 갖고 있게 되는 점이 단점이라 생각되었습니다.

### ⚒️ 해결방법 2 - 1개의 CollectionView 사용 + setCollectionViewLayout에서 애니메이션 제거
- 처음에 사용했던 방식을 적용하기 위해 아이콘 모드의 Cell Item들의 Spacing을 조절하여 레이아웃 에러를 해결하였습니다.
- `setCollectionViewLayout` 메서드를 그대로 사용하며 부자연스러운 기본 애니메이션은 사용하지 않았습니다.
- 대신 `해결방법 1`에서 정의해줬던 Custom Animation을 사용하여 자연스럽게 동작할 수 있도록 구현해주었습니다.

<br>

### 1️⃣2️⃣ URLCache를 원하는 방식(In-Memory / On-Disk)으로 사용
- 처음 앱을 실행시켰을 때 표시되는 화면은 박스오피스 순위를 표시해주는 화면입니다.
- 해당 화면에 정보를 표시하기 위해 API를 통해 서버와 통신을 해야하는데, 앱의 첫화면은 첫 인상이라는 생각으로 이때 생기는 로딩을 줄여주고자 박스오피스에 관련된 데이터는 On-Disk 방식으로 캐시하기로 했습니다.
- 박스오피스 순위를 표시해주는 화면에서 영화를 선택하면 나오는 상세화면에서는 상세정보를 받을 수 있는 API와 카카오 이미지 검색 API를 사용해야합니다.
- 따라서 캐시할 데이터가 날짜별로 영화별로 많이 존재하고, 사용자가 모든 영화를 선택하지 않을 수 있기 때문에 In-Memory로 캐시하도록 하였습니다.

### ⚒️ 해결방법

```swift
class URLCacheManager {
    private static let inMemoryCache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 0)
    private static let onDiskCache = URLCache(memoryCapacity: 0, diskCapacity: 20 * 1024 * 1024)
    
    private init() {}
    
    static func getURLCache<T: Decodable>(type: T.Type) -> URLCache {
        if type == BoxOffice.self {
            return onDiskCache
        } else {
            return inMemoryCache
        }
    }
}
```

- `In-Memory Capacity만 가진 inMemoryCache`와 `On-Disk Capacity만 가진 onDiskCache`를 생성해주어 원하는 방식만 사용할 수 있게 구현해주었습니다.

<br>

## 6. 팀회고
### 우리팀이 잘한 점
- 끝까지 모르는 부분에 대해서 해결하려고 노력하고 나름의 결론을 내린 점
- 한 달가량 프로젝트를 진행하면서 지치는 시간도 있었지만 서로 응원하며 열심히 한 점

### 우리팀이 노력할 점
- PR 올리는 시간 계획을 잘 세우고 리뷰어와 시간 협의를 잘 하자 !
- 프로젝트가 종료된 이후에도 해결되지 않았던 문제에 대해서 고민해보자 !

<br>

## 7. 참고 링크
- [Apple Docs - URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [Apple Docs - Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [Wiki - HTTP](https://ko.wikipedia.org/wiki/HTTP)
- [Apple Docs - UICollectionViewCompositionalLayout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout)
- [Apple Docs - UICollectionLayoutListConfiguration](https://developer.apple.com/documentation/uikit/uicollectionlayoutlistconfiguration)
- [WWDC2020 - Modern Cell Configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
- [Realm - Swift의 강력한 mock 객체 만들기](https://academy.realm.io/kr/posts/making-mock-objects-more-useful-try-swift-2017/)
- [Apple Docs - setCollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionview/1618017-setcollectionviewlayout)
- [Apple - URLCache](https://github.com/apple/swift-corelibs-foundation/blob/main/Sources/FoundationNetworking/URLCache.swift)
- [Apple - swift-corelibs-foundation(URLCache)](https://github.com/apple/swift-corelibs-foundation/blob/main/Sources/FoundationNetworking/URLCache.swift)

---


###### tags: `readme`
