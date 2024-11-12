# 📱 잡플래닛 과제
## 프로젝트 소개

- 잡플래닛의 주요 데이터 및 기능 인 채용 공고와 기업 데이터들을 UITableView, UICollectionView, UIStackView 등.. 다양한 UI객체로 나타냄
- 잡플래닛의 과제, 2023년 1월에 과제 전형에서 탈락한 이후 **ReactorKit으로 리팩토링**
- 잡플래닛에서 통보한 불합격 사유들을 커버
  
> 사유) 코드정리 미흡, UI 가이드 미 준수, MVVM 패턴 이해도 부족

## 과제 가이드 라인
<img width="669" alt="image" src="https://github.com/user-attachments/assets/1f77a582-4249-450e-adf6-05a4834ef77e">
<img width="669" alt="image" src="https://github.com/user-attachments/assets/e11099e6-0653-47c8-96b7-f59229b2918d">

## Figma
<img width="633" alt="image" src="https://github.com/user-attachments/assets/27486a68-bd1a-439f-92f6-ec4b717bd9f1">

## 그 외 기능
- 데이터의 검색 기능


<br>

## 팀원 구성

<div align="center">

| **신승욱** |
| :------: |
| [<img src="https://avatars.githubusercontent.com/u/69791286?v=4" height=150 width=150> <br/> @shinseunguk](https://github.com/shinseunguk) |

</div>

<br>

## 1. 개발 환경

- **프론트엔드**: iOS (UIKit + ReactorKit)
- **백엔드**: 잡플래닛 Test API
- **버전 및 이슈 관리**: Github
- **협업 툴**: Figma
- **라이브러리**: Kingfisher, Then, SnapKit, ReactorKit, RxCocoa, RxSwift, RxViewController, Moya
- **서비스 배포 환경**: 로컬 구동

<br>

## 2. 채택한 개발 기술과 문제 해결 (Trouble Shooting)

### 채택한 개발 기술

#### UIKit & ReactorKit
- **UIKit**과 **ReactorKit**을 조합하여, UIKit 기반의 화면 구성을 리액티브하게 개발했습니다. ReactorKit을 통해 상태와 로직을 분리하고, UI와 데이터 처리를 명확하게 할 수 있었습니다. 이를 통해 상태 변경이 UI에 즉각적으로 반영되고, 코드의 유지보수성을 높일 수 있었습니다.

#### RxSwift와 RxCocoa
- **RxSwift**와 **RxCocoa**를 사용하여 데이터 스트림을 관리하고 비동기 작업을 처리했습니다. 비동기 처리가 많은 환경에서 메모리 누수를 방지하기 위해 DisposeBag을 활용하였고, 다양한 연산자를 통해 복잡한 데이터 흐름을 효율적으로 관리했습니다.

#### SnapKit
- **SnapKit**을 사용하여 코드 기반으로 레이아웃을 구성했습니다. 이를 통해 UI 구성을 직관적으로 할 수 있었으며, 코드의 가독성과 유지보수성을 높이는 데 도움이 되었습니다.

#### Kingfisher
- **Kingfisher**를 통해 이미지를 네트워크에서 불러오고 캐싱하는 기능을 구현했습니다. 이는 성능을 개선하고, 이미지 로딩에 따른 사용자 경험을 향상시키는 데 도움을 주었습니다.
  
<br><br>

### 버전 관리 및 협업

#### GitFlow
- **GitFlow**를 채택하여 버전 관리를 체계적으로 진행했습니다. **master** 브랜치는 안정 버전으로 유지하고, **develop** 브랜치를 통해 새로운 기능을 개발, **feature** 브랜치를 통해 기능별 작업을 분리했습니다. 배포 전에는 **release** 브랜치에서 안정화 과정을 거쳤으며, 긴급 업데이트는 **hotfix** 브랜치를 통해 신속히 대응하여 버전의 일관성과 안정성을 유지했습니다.

---

이 구조를 통해 협업 시 효율적으로 기능을 분리하고 통합할 수 있었으며, 문제 발생 시 신속히 대응할 수 있었습니다.

## Trouble Shooting
1. Reactor의 State가 변경됨과 동시에 Cell의 UILabel이 사라지는 현상
<div align="center">
    <img src="https://github.com/user-attachments/assets/ce7e9bd8-93d9-4055-bad5-7f0c3ab90047" width="300">
</div>

> 해결 방법
- UICollectionViewCell의 특징인 cell을 reuse하여 메모리를 아끼는 특성 때문에 해당 코드를 삽입 하였음.
```swift
override func prepareForReuse() {
        self.companyLogoImageView.image = nil
        self.companyLabel.text = ""
        self.industryNameLabel.text = ""
        self.ratingLabel.text = ""
        self.companyReviewLabel.text = ""
        self.salaryAvgMoneyLabel.text = ""
        self.interviewQuestionContentLabel.text = ""
    }
```
<br>

2. 메모리가 기하습수적으로 늘어나는 현상
- 테스트를 위해 화면 이동을 진행중, 메모리가 늘어나는 현상을 발견

<div align="center">
  <img width="406" alt=" 2024-11-12 오후 4 48 46" src="https://github.com/user-attachments/assets/2926e1b5-9c70-4200-8a35-e3b48f40da01">
</div>


> 원인 
1. API를 호출하는 인스턴스가 메모리가 해제 되지 않고 쌓임
2. UICollectionView의 Subview인 WLBLabel 또한 메모리가 해제 되지 않고 쌓임

<br>

> 해결
1. API를 호출하는 인스턴스를 싱글톤으로 처리
2. UICollectionView의 preparereuse()에서 객체가 메모리에 남지 않게 처리
```swift
    override func prepareForReuse() {
        self.imageView.image = nil
        
        self.titleLabel.text = ""
        self.ratingLabel.text = ""
        self.companyLabel.text = ""
        self.rewardLabel.text = ""
        
        // stackView 내부의 모든 arrangedSubview 제거
        stackView.arrangedSubviews.forEach { subview in
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        // contentView에서 추가된 wlbLabel 인스턴스를 제거
        contentView.subviews.filter { $0 is WLBLabel }.forEach {
            $0.removeFromSuperview()
        }
    }
}
```



<br>

## 3. 프로젝트 구조

```
.
├── JobPlanet-MVVM
│   ├── AppDelegate
│   │   ├── AppDelegate.swift
│   │   └── SceneDelegate.swift
│   ├── Base.lproj
│   ├── Extension
│   │   ├── Int+Extension.swift
│   │   ├── Reactive+Extension.swift
│   │   ├── UIColor+Extension.swift
│   │   ├── UILabel+Extension.swift
│   │   └── UIViewController+Extension.swift
│   ├── Info.plist
│   ├── Presentation
│   │   ├── Common
│   │   │   ├── UIButton
│   │   │   │   ├── RecentSearchButton.swift
│   │   │   │   └── ToggleButon.swift
│   │   │   ├── UICollectionViewCell
│   │   │   │   └── EmploymentCollectionViewCell.swift
│   │   │   ├── UILabel
│   │   │   │   ├── CompanyLabel.swift
│   │   │   │   └── WLBLabel.swift
│   │   │   └── UITableViewCell
│   │   │       ├── CompanyTableViewCell.swift
│   │   │       ├── ReviewTableViewCell.swift
│   │   │       └── ThemeTableViewCell.swift
│   │   ├── Main
│   │   │   ├── MainReactor.swift
│   │   │   └── MainViewController.swift
│   │   ├── SearchInput
│   │   │   ├── SearchInputReactor.swift
│   │   │   └── SearchInputViewController.swift
│   │   └── SearchResult
│   │       ├── SearchResultReactor.swift
│   │       └── SearchResultViewController.swift
│   ├── Protocol
│   │   └── ViewAttributes.swift
│   ├── Resources
│   │   └── Assets.xcassets
│   │       ├── AccentColor.colorset
│   │       │   └── Contents.json
│   │       ├── AppIcon.appiconset
│   │       │   └── Contents.json
│   │       ├── Contents.json
│   │       ├── icon_bookmark.imageset
│   │       │   ├── Contents.json
│   │       │   ├── icon_bookmark.png
│   │       │   ├── icon_bookmark@2x.png
│   │       │   └── icon_bookmark@3x.png
│   │       ├── icon_bookmark_off.imageset
│   │       │   ├── Contents.json
│   │       │   ├── icon_bookmark_off.png
│   │       │   ├── icon_bookmark_off@2x.png
│   │       │   └── icon_bookmark_off@3x.png
│   │       ├── icon_quote.imageset
│   │       │   ├── Contents.json
│   │       │   ├── icon_quote.png
│   │       │   ├── icon_quote@2x.png
│   │       │   └── icon_quote@3x.png
│   │       ├── icon_star.imageset
│   │       │   ├── Contents.json
│   │       │   ├── icon_star.png
│   │       │   ├── icon_star@2x.png
│   │       │   └── icon_star@3x.png
│   │       └── img_logo_search.imageset
│   │           ├── Contents.json
│   │           ├── img_logo_search.png
│   │           ├── img_logo_search@2x.png
│   │           └── img_logo_search@3x.png
│   ├── Service
│   │   ├── API
│   │   │   └── Main
│   │   │       ├── Enterprise.swift
│   │   │       ├── MainRouter.swift
│   │   │       ├── MainService.swift
│   │   │       └── Recruit.swift
│   │   └── UserDefaults
│   │       └── AppUserDefaults.swift
│   └── StoryBoard
│       └── Base.lproj
│           ├── LaunchScreen.storyboard
│           └── Main.storyboard
├── JobPlanet-MVVM.xcodeproj
│   ├── project.pbxproj
│   ├── project.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   ├── xcshareddata
│   │   │   ├── IDEWorkspaceChecks.plist
│   │   │   └── swiftpm
│   │   │       └── configuration
│   │   └── xcuserdata
│   │       └── incross0915.xcuserdatad
│   │           └── UserInterfaceState.xcuserstate
│   └── xcuserdata
│       └── incross0915.xcuserdatad
│           └── xcschemes
│               └── xcschememanagement.plist
├── JobPlanet-MVVM.xcworkspace
│   ├── contents.xcworkspacedata
│   ├── xcshareddata
│   │   ├── IDEWorkspaceChecks.plist
│   │   └── swiftpm
│   │       └── configuration
│   └── xcuserdata
│       └── incross0915.xcuserdatad
│           ├── UserInterfaceState.xcuserstate
│           └── xcdebugger
│               └── Breakpoints_v2.xcbkptlist
├── JobPlanet-MVVMTests
│   └── JobPlanet_MVVMTests.swift
├── JobPlanet-MVVMUITests
│   ├── JobPlanet_MVVMUITests.swift
│   └── JobPlanet_MVVMUITestsLaunchTests.swift
├── Podfile
├── Podfile.lock
└── Pods
    ├── Alamofire
    │   ├── LICENSE
    │   ├── README.md
    │   └── Source
    │       ├── Alamofire.swift
    │       ├── Core
    │       │   ├── AFError.swift
    │       │   ├── DataRequest.swift
    │       │   ├── DataStreamRequest.swift
    │       │   ├── DownloadRequest.swift
    │       │   ├── HTTPHeaders.swift
    │       │   ├── HTTPMethod.swift
    │       │   ├── Notifications.swift
    │       │   ├── ParameterEncoder.swift
    │       │   ├── ParameterEncoding.swift
    │       │   ├── Protected.swift
    │       │   ├── Request.swift
    │       │   ├── RequestTaskMap.swift
    │       │   ├── Response.swift
    │       │   ├── Session.swift
    │       │   ├── SessionDelegate.swift
    │       │   ├── URLConvertible+URLRequestConvertible.swift
    │       │   ├── UploadRequest.swift
    │       │   └── WebSocketRequest.swift
    │       ├── Extensions
    │       │   ├── DispatchQueue+Alamofire.swift
    │       │   ├── OperationQueue+Alamofire.swift
    │       │   ├── Result+Alamofire.swift
    │       │   ├── StringEncoding+Alamofire.swift
    │       │   ├── URLRequest+Alamofire.swift
    │       │   └── URLSessionConfiguration+Alamofire.swift
    │       ├── Features
    │       │   ├── AlamofireExtended.swift
    │       │   ├── AuthenticationInterceptor.swift
    │       │   ├── CachedResponseHandler.swift
    │       │   ├── Combine.swift
    │       │   ├── Concurrency.swift
    │       │   ├── EventMonitor.swift
    │       │   ├── MultipartFormData.swift
    │       │   ├── MultipartUpload.swift
    │       │   ├── NetworkReachabilityManager.swift
    │       │   ├── RedirectHandler.swift
    │       │   ├── RequestCompression.swift
    │       │   ├── RequestInterceptor.swift
    │       │   ├── ResponseSerialization.swift
    │       │   ├── RetryPolicy.swift
    │       │   ├── ServerTrustEvaluation.swift
    │       │   ├── URLEncodedFormEncoder.swift
    │       │   └── Validation.swift
    │       └── PrivacyInfo.xcprivacy
    ├── Headers
    ├── Kingfisher
    │   ├── LICENSE
    │   ├── README.md
    │   └── Sources
    │       ├── Cache
    │       │   ├── CacheSerializer.swift
    │       │   ├── DiskStorage.swift
    │       │   ├── FormatIndicatedCacheSerializer.swift
    │       │   ├── ImageCache.swift
    │       │   ├── MemoryStorage.swift
    │       │   └── Storage.swift
    │       ├── Documentation.docc
    │       │   └── Resources
    │       │       └── code-files
    │       │           ├── 01-SampleCell-1.swift
    │       │           ├── 01-SampleCell-2.swift
    │       │           ├── 01-SampleCell-3.swift
    │       │           ├── 01-ViewController-1.swift
    │       │           ├── 01-ViewController-10.swift
    │       │           ├── 01-ViewController-11.swift
    │       │           ├── 01-ViewController-12.swift
    │       │           ├── 01-ViewController-13.swift
    │       │           ├── 01-ViewController-2.swift
    │       │           ├── 01-ViewController-3.swift
    │       │           ├── 01-ViewController-4.swift
    │       │           ├── 01-ViewController-5.swift
    │       │           ├── 01-ViewController-6-0.swift
    │       │           ├── 01-ViewController-6.swift
    │       │           ├── 01-ViewController-7.swift
    │       │           ├── 01-ViewController-8.swift
    │       │           ├── 01-ViewController-9.swift
    │       │           ├── 02-ContentView-1.swift
    │       │           ├── 02-ContentView-10.swift
    │       │           ├── 02-ContentView-11.swift
    │       │           ├── 02-ContentView-2.swift
    │       │           ├── 02-ContentView-3.swift
    │       │           ├── 02-ContentView-4.swift
    │       │           ├── 02-ContentView-5.swift
    │       │           ├── 02-ContentView-6.swift
    │       │           ├── 02-ContentView-7.swift
    │       │           ├── 02-ContentView-8.swift
    │       │           └── 02-ContentView-9.swift
    │       ├── Extensions
    │       │   ├── CPListItem+Kingfisher.swift
    │       │   ├── HasImageComponent+Kingfisher.swift
    │       │   ├── ImageView+Kingfisher.swift
    │       │   ├── NSButton+Kingfisher.swift
    │       │   ├── NSTextAttachment+Kingfisher.swift
    │       │   ├── PHLivePhotoView+Kingfisher.swift
    │       │   └── UIButton+Kingfisher.swift
    │       ├── General
    │       │   ├── ImageSource
    │       │   │   ├── AVAssetImageDataProvider.swift
    │       │   │   ├── ImageDataProvider.swift
    │       │   │   ├── LivePhotoSource.swift
    │       │   │   ├── PHPickerResultImageDataProvider.swift
    │       │   │   ├── Resource.swift
    │       │   │   └── Source.swift
    │       │   ├── KF.swift
    │       │   ├── KFOptionsSetter.swift
    │       │   ├── Kingfisher.swift
    │       │   ├── KingfisherError.swift
    │       │   ├── KingfisherManager+LivePhoto.swift
    │       │   ├── KingfisherManager.swift
    │       │   └── KingfisherOptionsInfo.swift
    │       ├── Image
    │       │   ├── Filter.swift
    │       │   ├── GIFAnimatedImage.swift
    │       │   ├── GraphicsContext.swift
    │       │   ├── Image.swift
    │       │   ├── ImageDrawing.swift
    │       │   ├── ImageFormat.swift
    │       │   ├── ImageProcessor.swift
    │       │   ├── ImageProgressive.swift
    │       │   ├── ImageTransition.swift
    │       │   └── Placeholder.swift
    │       ├── Networking
    │       │   ├── AuthenticationChallengeResponsable.swift
    │       │   ├── ImageDataProcessor.swift
    │       │   ├── ImageDownloader+LivePhoto.swift
    │       │   ├── ImageDownloader.swift
    │       │   ├── ImageDownloaderDelegate.swift
    │       │   ├── ImageModifier.swift
    │       │   ├── ImagePrefetcher.swift
    │       │   ├── RedirectHandler.swift
    │       │   ├── RequestModifier.swift
    │       │   ├── RetryStrategy.swift
    │       │   ├── SessionDataTask.swift
    │       │   └── SessionDelegate.swift
    │       ├── PrivacyInfo.xcprivacy
    │       ├── SwiftUI
    │       │   ├── ImageBinder.swift
    │       │   ├── ImageContext.swift
    │       │   ├── KFAnimatedImage.swift
    │       │   ├── KFImage.swift
    │       │   ├── KFImageOptions.swift
    │       │   ├── KFImageProtocol.swift
    │       │   └── KFImageRenderer.swift
    │       ├── Utility
    │       │   ├── Box.swift
    │       │   ├── CallbackQueue.swift
    │       │   ├── Delegate.swift
    │       │   ├── DisplayLink.swift
    │       │   ├── ExtensionHelpers.swift
    │       │   ├── Result.swift
    │       │   ├── Runtime.swift
    │       │   ├── SizeExtensions.swift
    │       │   └── String+SHA256.swift
    │       └── Views
    │           ├── AnimatedImageView.swift
    │           └── Indicator.swift
    ├── Local Podspecs
    ├── Manifest.lock
    ├── Moya
    │   ├── License.md
    │   ├── Readme.md
    │   └── Sources
    │       └── Moya
    │           ├── AnyEncodable.swift
    │           ├── Atomic.swift
    │           ├── Cancellable.swift
    │           ├── Endpoint.swift
    │           ├── Image.swift
    │           ├── Moya+Alamofire.swift
    │           ├── MoyaError.swift
    │           ├── MoyaProvider+Defaults.swift
    │           ├── MoyaProvider+Internal.swift
    │           ├── MoyaProvider.swift
    │           ├── MultiTarget.swift
    │           ├── MultipartFormData.swift
    │           ├── Plugin.swift
    │           ├── Plugins
    │           │   ├── AccessTokenPlugin.swift
    │           │   ├── CredentialsPlugin.swift
    │           │   ├── NetworkActivityPlugin.swift
    │           │   └── NetworkLoggerPlugin.swift
    │           ├── RequestTypeWrapper.swift
    │           ├── Response.swift
    │           ├── TargetType.swift
    │           ├── Task.swift
    │           ├── URL+Moya.swift
    │           ├── URLRequest+Encoding.swift
    │           └── ValidationType.swift
    ├── Pods.xcodeproj
    │   ├── project.pbxproj
    │   └── xcuserdata
    │       └── incross0915.xcuserdatad
    │           └── xcschemes
    │               ├── Alamofire-Alamofire.xcscheme
    │               ├── Alamofire.xcscheme
    │               ├── Kingfisher-Kingfisher.xcscheme
    │               ├── Kingfisher.xcscheme
    │               ├── Moya.xcscheme
    │               ├── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests.xcscheme
    │               ├── Pods-JobPlanet-MVVM.xcscheme
    │               ├── Pods-JobPlanet-MVVMTests.xcscheme
    │               ├── ReactorKit.xcscheme
    │               ├── RxCocoa-RxCocoa_Privacy.xcscheme
    │               ├── RxCocoa.xcscheme
    │               ├── RxRelay-RxRelay_Privacy.xcscheme
    │               ├── RxRelay.xcscheme
    │               ├── RxSwift-RxSwift_Privacy.xcscheme
    │               ├── RxSwift.xcscheme
    │               ├── RxViewController.xcscheme
    │               ├── SnapKit-SnapKit_Privacy.xcscheme
    │               ├── SnapKit.xcscheme
    │               ├── Then.xcscheme
    │               ├── WeakMapTable.xcscheme
    │               └── xcschememanagement.plist
    ├── ReactorKit
    │   ├── LICENSE
    │   ├── README.md
    │   └── Sources
    │       ├── ReactorKit
    │       │   ├── ActionSubject.swift
    │       │   ├── Exports.swift
    │       │   ├── IdentityEquatable.swift
    │       │   ├── IdentityHashable.swift
    │       │   ├── Pulse.swift
    │       │   ├── Reactor+Pulse.swift
    │       │   ├── Reactor.swift
    │       │   ├── StateRelay.swift
    │       │   ├── StoryboardView.swift
    │       │   ├── Stub.swift
    │       │   └── View.swift
    │       └── ReactorKitRuntime
    │           ├── ReactorKitRuntime.m
    │           └── include
    │               └── ReactorKitRuntime.h
    ├── RxCocoa
    │   ├── LICENSE.md
    │   ├── Platform
    │   │   ├── DataStructures
    │   │   │   ├── Bag.swift
    │   │   │   ├── InfiniteSequence.swift
    │   │   │   ├── PriorityQueue.swift
    │   │   │   └── Queue.swift
    │   │   ├── DispatchQueue+Extensions.swift
    │   │   ├── Platform.Darwin.swift
    │   │   ├── Platform.Linux.swift
    │   │   └── RecursiveLock.swift
    │   ├── README.md
    │   ├── RxCocoa
    │   │   ├── Common
    │   │   │   ├── ControlTarget.swift
    │   │   │   ├── DelegateProxy.swift
    │   │   │   ├── DelegateProxyType.swift
    │   │   │   ├── Infallible+Bind.swift
    │   │   │   ├── Observable+Bind.swift
    │   │   │   ├── RxCocoaObjCRuntimeError+Extensions.swift
    │   │   │   ├── RxTarget.swift
    │   │   │   ├── SectionedViewDataSourceType.swift
    │   │   │   └── TextInput.swift
    │   │   ├── Foundation
    │   │   │   ├── KVORepresentable+CoreGraphics.swift
    │   │   │   ├── KVORepresentable+Swift.swift
    │   │   │   ├── KVORepresentable.swift
    │   │   │   ├── NSObject+Rx+KVORepresentable.swift
    │   │   │   ├── NSObject+Rx+RawRepresentable.swift
    │   │   │   ├── NSObject+Rx.swift
    │   │   │   ├── NotificationCenter+Rx.swift
    │   │   │   └── URLSession+Rx.swift
    │   │   ├── Runtime
    │   │   │   ├── _RX.m
    │   │   │   ├── _RXDelegateProxy.m
    │   │   │   ├── _RXKVOObserver.m
    │   │   │   ├── _RXObjCRuntime.m
    │   │   │   └── include
    │   │   │       ├── RxCocoaRuntime.h
    │   │   │       ├── _RX.h
    │   │   │       ├── _RXDelegateProxy.h
    │   │   │       ├── _RXKVOObserver.h
    │   │   │       └── _RXObjCRuntime.h
    │   │   ├── RxCocoa.h
    │   │   ├── RxCocoa.swift
    │   │   ├── Traits
    │   │   │   ├── ControlEvent.swift
    │   │   │   ├── ControlProperty.swift
    │   │   │   ├── Driver
    │   │   │   │   ├── BehaviorRelay+Driver.swift
    │   │   │   │   ├── ControlEvent+Driver.swift
    │   │   │   │   ├── ControlProperty+Driver.swift
    │   │   │   │   ├── Driver+Subscription.swift
    │   │   │   │   ├── Driver.swift
    │   │   │   │   ├── Infallible+Driver.swift
    │   │   │   │   └── ObservableConvertibleType+Driver.swift
    │   │   │   ├── SharedSequence
    │   │   │   │   ├── ObservableConvertibleType+SharedSequence.swift
    │   │   │   │   ├── SchedulerType+SharedSequence.swift
    │   │   │   │   ├── SharedSequence+Concurrency.swift
    │   │   │   │   ├── SharedSequence+Operators+arity.swift
    │   │   │   │   ├── SharedSequence+Operators.swift
    │   │   │   │   └── SharedSequence.swift
    │   │   │   └── Signal
    │   │   │       ├── ControlEvent+Signal.swift
    │   │   │       ├── ObservableConvertibleType+Signal.swift
    │   │   │       ├── PublishRelay+Signal.swift
    │   │   │       ├── Signal+Subscription.swift
    │   │   │       └── Signal.swift
    │   │   ├── iOS
    │   │   │   ├── DataSources
    │   │   │   │   ├── RxCollectionViewReactiveArrayDataSource.swift
    │   │   │   │   ├── RxPickerViewAdapter.swift
    │   │   │   │   └── RxTableViewReactiveArrayDataSource.swift
    │   │   │   ├── Events
    │   │   │   │   └── ItemEvents.swift
    │   │   │   ├── NSTextStorage+Rx.swift
    │   │   │   ├── Protocols
    │   │   │   │   ├── RxCollectionViewDataSourceType.swift
    │   │   │   │   ├── RxPickerViewDataSourceType.swift
    │   │   │   │   └── RxTableViewDataSourceType.swift
    │   │   │   ├── Proxies
    │   │   │   │   ├── RxCollectionViewDataSourcePrefetchingProxy.swift
    │   │   │   │   ├── RxCollectionViewDataSourceProxy.swift
    │   │   │   │   ├── RxCollectionViewDelegateProxy.swift
    │   │   │   │   ├── RxNavigationControllerDelegateProxy.swift
    │   │   │   │   ├── RxPickerViewDataSourceProxy.swift
    │   │   │   │   ├── RxPickerViewDelegateProxy.swift
    │   │   │   │   ├── RxScrollViewDelegateProxy.swift
    │   │   │   │   ├── RxSearchBarDelegateProxy.swift
    │   │   │   │   ├── RxSearchControllerDelegateProxy.swift
    │   │   │   │   ├── RxTabBarControllerDelegateProxy.swift
    │   │   │   │   ├── RxTabBarDelegateProxy.swift
    │   │   │   │   ├── RxTableViewDataSourcePrefetchingProxy.swift
    │   │   │   │   ├── RxTableViewDataSourceProxy.swift
    │   │   │   │   ├── RxTableViewDelegateProxy.swift
    │   │   │   │   ├── RxTextStorageDelegateProxy.swift
    │   │   │   │   ├── RxTextViewDelegateProxy.swift
    │   │   │   │   └── RxWKNavigationDelegateProxy.swift
    │   │   │   ├── UIActivityIndicatorView+Rx.swift
    │   │   │   ├── UIApplication+Rx.swift
    │   │   │   ├── UIBarButtonItem+Rx.swift
    │   │   │   ├── UIButton+Rx.swift
    │   │   │   ├── UICollectionView+Rx.swift
    │   │   │   ├── UIControl+Rx.swift
    │   │   │   ├── UIDatePicker+Rx.swift
    │   │   │   ├── UIGestureRecognizer+Rx.swift
    │   │   │   ├── UINavigationController+Rx.swift
    │   │   │   ├── UIPickerView+Rx.swift
    │   │   │   ├── UIRefreshControl+Rx.swift
    │   │   │   ├── UIScrollView+Rx.swift
    │   │   │   ├── UISearchBar+Rx.swift
    │   │   │   ├── UISearchController+Rx.swift
    │   │   │   ├── UISegmentedControl+Rx.swift
    │   │   │   ├── UISlider+Rx.swift
    │   │   │   ├── UIStepper+Rx.swift
    │   │   │   ├── UISwitch+Rx.swift
    │   │   │   ├── UITabBar+Rx.swift
    │   │   │   ├── UITabBarController+Rx.swift
    │   │   │   ├── UITableView+Rx.swift
    │   │   │   ├── UITextField+Rx.swift
    │   │   │   ├── UITextView+Rx.swift
    │   │   │   └── WKWebView+Rx.swift
    │   │   └── macOS
    │   │       ├── NSButton+Rx.swift
    │   │       ├── NSControl+Rx.swift
    │   │       ├── NSSlider+Rx.swift
    │   │       ├── NSTextField+Rx.swift
    │   │       ├── NSTextView+Rx.swift
    │   │       └── NSView+Rx.swift
    │   └── Sources
    │       └── RxCocoa
    │           └── PrivacyInfo.xcprivacy
    ├── RxRelay
    │   ├── LICENSE.md
    │   ├── README.md
    │   ├── RxRelay
    │   │   ├── BehaviorRelay.swift
    │   │   ├── Observable+Bind.swift
    │   │   ├── PublishRelay.swift
    │   │   ├── ReplayRelay.swift
    │   │   └── Utils.swift
    │   └── Sources
    │       └── RxRelay
    │           └── PrivacyInfo.xcprivacy
    ├── RxSwift
    │   ├── LICENSE.md
    │   ├── Platform
    │   │   ├── AtomicInt.swift
    │   │   ├── DataStructures
    │   │   │   ├── Bag.swift
    │   │   │   ├── InfiniteSequence.swift
    │   │   │   ├── PriorityQueue.swift
    │   │   │   └── Queue.swift
    │   │   ├── DispatchQueue+Extensions.swift
    │   │   ├── Platform.Darwin.swift
    │   │   ├── Platform.Linux.swift
    │   │   └── RecursiveLock.swift
    │   ├── README.md
    │   ├── RxSwift
    │   │   ├── AnyObserver.swift
    │   │   ├── Binder.swift
    │   │   ├── Cancelable.swift
    │   │   ├── Concurrency
    │   │   │   ├── AsyncLock.swift
    │   │   │   ├── Lock.swift
    │   │   │   ├── LockOwnerType.swift
    │   │   │   ├── SynchronizedDisposeType.swift
    │   │   │   ├── SynchronizedOnType.swift
    │   │   │   └── SynchronizedUnsubscribeType.swift
    │   │   ├── ConnectableObservableType.swift
    │   │   ├── Date+Dispatch.swift
    │   │   ├── Disposable.swift
    │   │   ├── Disposables
    │   │   │   ├── AnonymousDisposable.swift
    │   │   │   ├── BinaryDisposable.swift
    │   │   │   ├── BooleanDisposable.swift
    │   │   │   ├── CompositeDisposable.swift
    │   │   │   ├── Disposables.swift
    │   │   │   ├── DisposeBag.swift
    │   │   │   ├── DisposeBase.swift
    │   │   │   ├── NopDisposable.swift
    │   │   │   ├── RefCountDisposable.swift
    │   │   │   ├── ScheduledDisposable.swift
    │   │   │   ├── SerialDisposable.swift
    │   │   │   ├── SingleAssignmentDisposable.swift
    │   │   │   └── SubscriptionDisposable.swift
    │   │   ├── Errors.swift
    │   │   ├── Event.swift
    │   │   ├── Extensions
    │   │   │   └── Bag+Rx.swift
    │   │   ├── GroupedObservable.swift
    │   │   ├── ImmediateSchedulerType.swift
    │   │   ├── Observable+Concurrency.swift
    │   │   ├── Observable.swift
    │   │   ├── ObservableConvertibleType.swift
    │   │   ├── ObservableType+Extensions.swift
    │   │   ├── ObservableType.swift
    │   │   ├── Observables
    │   │   │   ├── AddRef.swift
    │   │   │   ├── Amb.swift
    │   │   │   ├── AsMaybe.swift
    │   │   │   ├── AsSingle.swift
    │   │   │   ├── Buffer.swift
    │   │   │   ├── Catch.swift
    │   │   │   ├── CombineLatest+Collection.swift
    │   │   │   ├── CombineLatest+arity.swift
    │   │   │   ├── CombineLatest.swift
    │   │   │   ├── CompactMap.swift
    │   │   │   ├── Concat.swift
    │   │   │   ├── Create.swift
    │   │   │   ├── Debounce.swift
    │   │   │   ├── Debug.swift
    │   │   │   ├── Decode.swift
    │   │   │   ├── DefaultIfEmpty.swift
    │   │   │   ├── Deferred.swift
    │   │   │   ├── Delay.swift
    │   │   │   ├── DelaySubscription.swift
    │   │   │   ├── Dematerialize.swift
    │   │   │   ├── DistinctUntilChanged.swift
    │   │   │   ├── Do.swift
    │   │   │   ├── ElementAt.swift
    │   │   │   ├── Empty.swift
    │   │   │   ├── Enumerated.swift
    │   │   │   ├── Error.swift
    │   │   │   ├── Filter.swift
    │   │   │   ├── First.swift
    │   │   │   ├── Generate.swift
    │   │   │   ├── GroupBy.swift
    │   │   │   ├── Just.swift
    │   │   │   ├── Map.swift
    │   │   │   ├── Materialize.swift
    │   │   │   ├── Merge.swift
    │   │   │   ├── Multicast.swift
    │   │   │   ├── Never.swift
    │   │   │   ├── ObserveOn.swift
    │   │   │   ├── Optional.swift
    │   │   │   ├── Producer.swift
    │   │   │   ├── Range.swift
    │   │   │   ├── Reduce.swift
    │   │   │   ├── Repeat.swift
    │   │   │   ├── RetryWhen.swift
    │   │   │   ├── Sample.swift
    │   │   │   ├── Scan.swift
    │   │   │   ├── Sequence.swift
    │   │   │   ├── ShareReplayScope.swift
    │   │   │   ├── SingleAsync.swift
    │   │   │   ├── Sink.swift
    │   │   │   ├── Skip.swift
    │   │   │   ├── SkipUntil.swift
    │   │   │   ├── SkipWhile.swift
    │   │   │   ├── StartWith.swift
    │   │   │   ├── SubscribeOn.swift
    │   │   │   ├── Switch.swift
    │   │   │   ├── SwitchIfEmpty.swift
    │   │   │   ├── Take.swift
    │   │   │   ├── TakeLast.swift
    │   │   │   ├── TakeWithPredicate.swift
    │   │   │   ├── Throttle.swift
    │   │   │   ├── Timeout.swift
    │   │   │   ├── Timer.swift
    │   │   │   ├── ToArray.swift
    │   │   │   ├── Using.swift
    │   │   │   ├── Window.swift
    │   │   │   ├── WithLatestFrom.swift
    │   │   │   ├── WithUnretained.swift
    │   │   │   ├── Zip+Collection.swift
    │   │   │   ├── Zip+arity.swift
    │   │   │   └── Zip.swift
    │   │   ├── ObserverType.swift
    │   │   ├── Observers
    │   │   │   ├── AnonymousObserver.swift
    │   │   │   ├── ObserverBase.swift
    │   │   │   └── TailRecursiveSink.swift
    │   │   ├── Reactive.swift
    │   │   ├── Rx.swift
    │   │   ├── RxMutableBox.swift
    │   │   ├── SchedulerType.swift
    │   │   ├── Schedulers
    │   │   │   ├── ConcurrentDispatchQueueScheduler.swift
    │   │   │   ├── ConcurrentMainScheduler.swift
    │   │   │   ├── CurrentThreadScheduler.swift
    │   │   │   ├── HistoricalScheduler.swift
    │   │   │   ├── HistoricalSchedulerTimeConverter.swift
    │   │   │   ├── Internal
    │   │   │   │   ├── DispatchQueueConfiguration.swift
    │   │   │   │   ├── InvocableScheduledItem.swift
    │   │   │   │   ├── InvocableType.swift
    │   │   │   │   ├── ScheduledItem.swift
    │   │   │   │   └── ScheduledItemType.swift
    │   │   │   ├── MainScheduler.swift
    │   │   │   ├── OperationQueueScheduler.swift
    │   │   │   ├── RecursiveScheduler.swift
    │   │   │   ├── SchedulerServices+Emulation.swift
    │   │   │   ├── SerialDispatchQueueScheduler.swift
    │   │   │   ├── VirtualTimeConverterType.swift
    │   │   │   └── VirtualTimeScheduler.swift
    │   │   ├── Subjects
    │   │   │   ├── AsyncSubject.swift
    │   │   │   ├── BehaviorSubject.swift
    │   │   │   ├── PublishSubject.swift
    │   │   │   ├── ReplaySubject.swift
    │   │   │   └── SubjectType.swift
    │   │   ├── SwiftSupport
    │   │   │   └── SwiftSupport.swift
    │   │   └── Traits
    │   │       ├── Infallible
    │   │       │   ├── Infallible+CombineLatest+Collection.swift
    │   │       │   ├── Infallible+CombineLatest+arity.swift
    │   │       │   ├── Infallible+Concurrency.swift
    │   │       │   ├── Infallible+Create.swift
    │   │       │   ├── Infallible+Debug.swift
    │   │       │   ├── Infallible+Operators.swift
    │   │       │   ├── Infallible+Zip+arity.swift
    │   │       │   ├── Infallible.swift
    │   │       │   └── ObservableConvertibleType+Infallible.swift
    │   │       └── PrimitiveSequence
    │   │           ├── Completable+AndThen.swift
    │   │           ├── Completable.swift
    │   │           ├── Maybe.swift
    │   │           ├── ObservableType+PrimitiveSequence.swift
    │   │           ├── PrimitiveSequence+Concurrency.swift
    │   │           ├── PrimitiveSequence+Zip+arity.swift
    │   │           ├── PrimitiveSequence.swift
    │   │           └── Single.swift
    │   └── Sources
    │       └── RxSwift
    │           └── PrivacyInfo.xcprivacy
    ├── RxViewController
    │   ├── LICENSE
    │   ├── README.md
    │   └── Sources
    │       └── RxViewController
    │           ├── NSViewController+Rx.swift
    │           └── UIViewController+Rx.swift
    ├── SnapKit
    │   ├── LICENSE
    │   ├── README.md
    │   └── Sources
    │       ├── Constraint.swift
    │       ├── ConstraintAttributes.swift
    │       ├── ConstraintConfig.swift
    │       ├── ConstraintConstantTarget.swift
    │       ├── ConstraintDSL.swift
    │       ├── ConstraintDescription.swift
    │       ├── ConstraintDirectionalInsetTarget.swift
    │       ├── ConstraintDirectionalInsets.swift
    │       ├── ConstraintInsetTarget.swift
    │       ├── ConstraintInsets.swift
    │       ├── ConstraintItem.swift
    │       ├── ConstraintLayoutGuide+Extensions.swift
    │       ├── ConstraintLayoutGuide.swift
    │       ├── ConstraintLayoutGuideDSL.swift
    │       ├── ConstraintLayoutSupport.swift
    │       ├── ConstraintLayoutSupportDSL.swift
    │       ├── ConstraintMaker.swift
    │       ├── ConstraintMakerEditable.swift
    │       ├── ConstraintMakerExtendable.swift
    │       ├── ConstraintMakerFinalizable.swift
    │       ├── ConstraintMakerPrioritizable.swift
    │       ├── ConstraintMakerRelatable+Extensions.swift
    │       ├── ConstraintMakerRelatable.swift
    │       ├── ConstraintMultiplierTarget.swift
    │       ├── ConstraintOffsetTarget.swift
    │       ├── ConstraintPriority.swift
    │       ├── ConstraintPriorityTarget.swift
    │       ├── ConstraintRelatableTarget.swift
    │       ├── ConstraintRelation.swift
    │       ├── ConstraintView+Extensions.swift
    │       ├── ConstraintView.swift
    │       ├── ConstraintViewDSL.swift
    │       ├── Debugging.swift
    │       ├── LayoutConstraint.swift
    │       ├── LayoutConstraintItem.swift
    │       ├── PrivacyInfo.xcprivacy
    │       ├── Typealiases.swift
    │       └── UILayoutSupport+Extensions.swift
    ├── Target Support Files
    │   ├── Alamofire
    │   │   ├── Alamofire-Info.plist
    │   │   ├── Alamofire-dummy.m
    │   │   ├── Alamofire-prefix.pch
    │   │   ├── Alamofire-umbrella.h
    │   │   ├── Alamofire.debug.xcconfig
    │   │   ├── Alamofire.modulemap
    │   │   ├── Alamofire.release.xcconfig
    │   │   └── ResourceBundle-Alamofire-Alamofire-Info.plist
    │   ├── Kingfisher
    │   │   ├── Kingfisher-Info.plist
    │   │   ├── Kingfisher-dummy.m
    │   │   ├── Kingfisher-prefix.pch
    │   │   ├── Kingfisher-umbrella.h
    │   │   ├── Kingfisher.debug.xcconfig
    │   │   ├── Kingfisher.modulemap
    │   │   ├── Kingfisher.release.xcconfig
    │   │   └── ResourceBundle-Kingfisher-Kingfisher-Info.plist
    │   ├── Moya
    │   │   ├── Moya-Info.plist
    │   │   ├── Moya-dummy.m
    │   │   ├── Moya-prefix.pch
    │   │   ├── Moya-umbrella.h
    │   │   ├── Moya.debug.xcconfig
    │   │   ├── Moya.modulemap
    │   │   └── Moya.release.xcconfig
    │   ├── Pods-JobPlanet-MVVM
    │   │   ├── Pods-JobPlanet-MVVM-Info.plist
    │   │   ├── Pods-JobPlanet-MVVM-acknowledgements.markdown
    │   │   ├── Pods-JobPlanet-MVVM-acknowledgements.plist
    │   │   ├── Pods-JobPlanet-MVVM-dummy.m
    │   │   ├── Pods-JobPlanet-MVVM-frameworks-Debug-input-files.xcfilelist
    │   │   ├── Pods-JobPlanet-MVVM-frameworks-Debug-output-files.xcfilelist
    │   │   ├── Pods-JobPlanet-MVVM-frameworks-Release-input-files.xcfilelist
    │   │   ├── Pods-JobPlanet-MVVM-frameworks-Release-output-files.xcfilelist
    │   │   ├── Pods-JobPlanet-MVVM-frameworks.sh
    │   │   ├── Pods-JobPlanet-MVVM-umbrella.h
    │   │   ├── Pods-JobPlanet-MVVM.debug.xcconfig
    │   │   ├── Pods-JobPlanet-MVVM.modulemap
    │   │   └── Pods-JobPlanet-MVVM.release.xcconfig
    │   ├── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests
    │   │   ├── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests-Info.plist
    │   │   ├── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests-acknowledgements.markdown
    │   │   ├── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests-acknowledgements.plist
    │   │   ├── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests-dummy.m
    │   │   ├── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests-frameworks-Debug-input-files.xcfilelist
    │   │   ├── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests-frameworks-Debug-output-files.xcfilelist
    │   │   ├── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests-frameworks-Release-input-files.xcfilelist
    │   │   ├── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests-frameworks-Release-output-files.xcfilelist
    │   │   ├── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests-frameworks.sh
    │   │   ├── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests-umbrella.h
    │   │   ├── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests.debug.xcconfig
    │   │   ├── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests.modulemap
    │   │   └── Pods-JobPlanet-MVVM-JobPlanet-MVVMUITests.release.xcconfig
    │   ├── Pods-JobPlanet-MVVMTests
    │   │   ├── Pods-JobPlanet-MVVMTests-Info.plist
    │   │   ├── Pods-JobPlanet-MVVMTests-acknowledgements.markdown
    │   │   ├── Pods-JobPlanet-MVVMTests-acknowledgements.plist
    │   │   ├── Pods-JobPlanet-MVVMTests-dummy.m
    │   │   ├── Pods-JobPlanet-MVVMTests-umbrella.h
    │   │   ├── Pods-JobPlanet-MVVMTests.debug.xcconfig
    │   │   ├── Pods-JobPlanet-MVVMTests.modulemap
    │   │   └── Pods-JobPlanet-MVVMTests.release.xcconfig
    │   ├── ReactorKit
    │   │   ├── ReactorKit-Info.plist
    │   │   ├── ReactorKit-dummy.m
    │   │   ├── ReactorKit-prefix.pch
    │   │   ├── ReactorKit-umbrella.h
    │   │   ├── ReactorKit.debug.xcconfig
    │   │   ├── ReactorKit.modulemap
    │   │   └── ReactorKit.release.xcconfig
    │   ├── RxCocoa
    │   │   ├── ResourceBundle-RxCocoa_Privacy-RxCocoa-Info.plist
    │   │   ├── RxCocoa-Info.plist
    │   │   ├── RxCocoa-dummy.m
    │   │   ├── RxCocoa-prefix.pch
    │   │   ├── RxCocoa-umbrella.h
    │   │   ├── RxCocoa.debug.xcconfig
    │   │   ├── RxCocoa.modulemap
    │   │   └── RxCocoa.release.xcconfig
    │   ├── RxRelay
    │   │   ├── ResourceBundle-RxRelay_Privacy-RxRelay-Info.plist
    │   │   ├── RxRelay-Info.plist
    │   │   ├── RxRelay-dummy.m
    │   │   ├── RxRelay-prefix.pch
    │   │   ├── RxRelay-umbrella.h
    │   │   ├── RxRelay.debug.xcconfig
    │   │   ├── RxRelay.modulemap
    │   │   └── RxRelay.release.xcconfig
    │   ├── RxSwift
    │   │   ├── ResourceBundle-RxSwift_Privacy-RxSwift-Info.plist
    │   │   ├── RxSwift-Info.plist
    │   │   ├── RxSwift-dummy.m
    │   │   ├── RxSwift-prefix.pch
    │   │   ├── RxSwift-umbrella.h
    │   │   ├── RxSwift.debug.xcconfig
    │   │   ├── RxSwift.modulemap
    │   │   └── RxSwift.release.xcconfig
    │   ├── RxViewController
    │   │   ├── RxViewController-Info.plist
    │   │   ├── RxViewController-dummy.m
    │   │   ├── RxViewController-prefix.pch
    │   │   ├── RxViewController-umbrella.h
    │   │   ├── RxViewController.debug.xcconfig
    │   │   ├── RxViewController.modulemap
    │   │   └── RxViewController.release.xcconfig
    │   ├── SnapKit
    │   │   ├── ResourceBundle-SnapKit_Privacy-SnapKit-Info.plist
    │   │   ├── SnapKit-Info.plist
    │   │   ├── SnapKit-dummy.m
    │   │   ├── SnapKit-prefix.pch
    │   │   ├── SnapKit-umbrella.h
    │   │   ├── SnapKit.debug.xcconfig
    │   │   ├── SnapKit.modulemap
    │   │   └── SnapKit.release.xcconfig
    │   ├── Then
    │   │   ├── Then-Info.plist
    │   │   ├── Then-dummy.m
    │   │   ├── Then-prefix.pch
    │   │   ├── Then-umbrella.h
    │   │   ├── Then.debug.xcconfig
    │   │   ├── Then.modulemap
    │   │   └── Then.release.xcconfig
    │   └── WeakMapTable
    │       ├── WeakMapTable-Info.plist
    │       ├── WeakMapTable-dummy.m
    │       ├── WeakMapTable-prefix.pch
    │       ├── WeakMapTable-umbrella.h
    │       ├── WeakMapTable.debug.xcconfig
    │       ├── WeakMapTable.modulemap
    │       └── WeakMapTable.release.xcconfig
    ├── Then
    │   ├── LICENSE
    │   ├── README.md
    │   └── Sources
    │       └── Then
    │           └── Then.swift
    └── WeakMapTable
        ├── LICENSE
        ├── README.md
        └── Sources
            └── WeakMapTable
                └── WeakMapTable.swift

```

<br>

## 4. 역할 분담

### 🧑🏻‍💻신승욱
1. 탭 이동
> 탭을 이동하여 Navigation을 옮겨다니지 않아도 화면이 전환되는 효과를 주었음.

<div align="center">
  <img src="https://github.com/user-attachments/assets/354dcfd7-442d-40e8-9aa4-b1510647cd16">
</div>

<br>

2. UICollectionView 스크롤
> 잡플래닛 API를 통해 데이터를 가져오고(Moya 라이브러리 사용), 데이터들을 MVVM으로 순차대로 화면단에 적용


```json
{
    "recruit_items": [
        {
            "id": 1200,
            "title": "[잡플래닛] iOS 앱개발",
            "reward": 2000000,
            "appeal": "복지포인트, 스낵바, 자기계발비",
            "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2229/w750__EA_B8_B0_ED_9A_8D_ED_8C_80.jpg",
            "company": {
                "name": "잡플래닛",
                "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                "ratings": [
                    {
                        "type": "사내문화",
                        "rating": 3.6
                    },
                    {
                        "type": "워라밸",
                        "rating": 3.0
                    },
                    {
                        "type": "복지/급여",
                        "rating": 3.5
                    }
                ]
            }
        },
        {
            "id": 1201,
            "title": "[잡플래닛] Android 앱개발",
            "reward": 0,
            "appeal": "복지포인트100만원, 유연근무제, 단일호칭, 자율출퇴근, 패밀리데이",
            "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2126/w750__EC_95_88_EB_93_9C_EB_A1_9C_EC_9D_B4_EB_93_9C_1400_788.png",
            "company": {
                "name": "잡플래닛",
                "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                "ratings": [
                    {
                        "type": "경영진",
                        "rating": 2.0
                    },
                    {
                        "type": "CEO 지지도",
                        "rating": 4.0
                    },
                    {
                        "type": "복지/급여",
                        "rating": 3.5
                    }
                ]
            }
        },
        {
            "id": 1203,
            "title": "[잡플래닛] 프론트 엔드 개발자 (Senior)",
            "reward": 100000,
            "appeal": "복지포인트100만원, 유연근무제, 단일호칭, 자율출퇴근, 패밀리데이",
            "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2125/w750__ED_94_84_EB_A1_A0_ED_8A_B8_EC_97_94_EB_93_9C_ED_8C_80_1400_788.png",
            "company": {
                "name": "잡플래닛",
                "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                "ratings": [
                    {
                        "type": "경영진",
                        "rating": 2.0
                    },
                    {
                        "type": "CEO 지지도",
                        "rating": 4.0
                    },
                    {
                        "type": "복지/급여",
                        "rating": 4.1
                    }
                ]
            }
        },
        {
            "id": 1100,
            "title": "기술전문 상담사",
            "reward": 0,
            "appeal": "",
            "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/88038/thumb______.jpg",
            "company": {
                "name": "잡플래닛",
                "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/88038/thumb______.jpg",
                "ratings": [
                    {
                        "type": "사내문화",
                        "rating": 0.0
                    },
                    {
                        "type": "복지/급여",
                        "rating": 0.0
                    },
                    {
                        "type": "승진 가능성",
                        "rating": 0.0
                    }
                ]
            }
        },
        {
            "id": 1205,
            "title": "[잡플래닛] 백엔드 개발자 (Junior)",
            "reward": 500000,
            "appeal": "패밀리데이, 최신업무장비 복지포인트 100만원, 재택근무, 복지카드, 자율출퇴근",
            "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2117/w750__EB_B0_B1_EC_97_94_EB_93_9C_ED_8C_80_1400_788.png",
            "company": {
                "name": "잡플래닛",
                "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                "ratings": [
                    {
                        "type": "사내문화",
                        "rating": 2.0
                    },
                    {
                        "type": "복지/급여",
                        "rating": 3.0
                    },
                    {
                        "type": "승진 가능성",
                        "rating": 4.1
                    }
                ]
            }
        },
        {
            "id": 110,
            "title": "[잡플래닛] QA 엔지니어 팀장",
            "reward": 1000000,
            "appeal": "재택근무, 복지카드, 자율출퇴근, 패밀리데이",
            "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2113/w750_QA_ED_8C_80_1400_788.png",
            "company": {
                "name": "잡플래닛",
                "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                "ratings": [
                    {
                        "type": "사내문화",
                        "rating": 3.0
                    },
                    {
                        "type": "복지/급여",
                        "rating": 3.0
                    },
                    {
                        "type": "CEO 지지도",
                        "rating": 3.0
                    }
                ]
            }
        },
        {
            "id": 1010,
            "title": "[잡플래닛] 마케팅 제휴 본부장",
            "reward": 100000,
            "appeal": "최신업무장비 복지포인트 100만원, 재택근무, 복지카드, 자율출퇴근, 패밀리데이",
            "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2113/w750_QA_ED_8C_80_1400_788.png",
            "company": {
                "name": "잡플래닛",
                "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                "ratings": [
                    {
                        "type": "사내문화",
                        "rating": 3.1
                    },
                    {
                        "type": "복지/급여",
                        "rating": 3.0
                    },
                    {
                        "type": "승진 가능성",
                        "rating": 3.0
                    }
                ]
            }
        },
        {
            "id": 1300,
            "title": "사내 변호사(Junior)",
            "reward": 0,
            "appeal": "재택근무, 복지카드, 패밀리데이",
            "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/957/w750_00.thumbnail.png",
            "company": {
                "name": "잡플래닛",
                "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                "ratings": [
                    {
                        "type": "사내문화",
                        "rating": 4.0
                    },
                    {
                        "type": "복지/급여",
                        "rating": 4.1
                    },
                    {
                        "type": "승진 가능성",
                        "rating": 4.0
                    }
                ]
            }
        },
        {
            "id": 1301,
            "title": "전략제휴본부 서비스 운영 기획/관리 담당자",
            "reward": 0,
            "appeal": "",
            "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/88038/thumb______.jpg",
            "company": {
                "name": "잡플래닛",
                "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/88038/thumb______.jpg",
                "ratings": [
                    {
                        "type": "사내문화",
                        "rating": 4.0
                    },
                    {
                        "type": "복지/급여",
                        "rating": 4.0
                    },
                    {
                        "type": "승진 가능성",
                        "rating": 4.1
                    }
                ]
            }
        }
    ]
}
```

<div align="center">
  <img src="https://github.com/user-attachments/assets/16c58fcb-01a6-4ff2-a485-32dd09ee3543" width="400">
</div>
<br>



3. UITableView, CellType에 따른 cell분기 처리
> 잡플래닛 API를 통해 데이터를 가져오고(Moya 라이브러리 사용), 데이터들을 MVVM으로 순차대로 화면단에 적용

```json
{
    "cell_items": [
        {
            "cell_type": "CELL_TYPE_COMPANY",
            "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/82465/thumb_25.png",
            "name": "대교(주)",
            "industry_name": "교육업",
            "rate_total_avg": 2.63,
            "review_summary": "학습지 시장에서 높은 인지도를 가지고 있으나,\r\n학습지업 자체가 하락세이며 영업압박이 심함",
            "interview_question": "회사의 이익 규모에 대해 알고 있나?\r\n본인이 잘 할 수 있는 분야는?\r\n본인은 회사에서 장래 어떤 비전을 갖고 있나?",
            "salary_avg": 3483,
            "update_date": "2022-02-08T15:04:31.000+09:00"
        },
        {
            "cell_type": "CELL_TYPE_COMPANY",
            "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/88038/thumb______.jpg",
            "name": "바이널아이",
            "industry_name": "미디어/디자인",
            "rate_total_avg": 2.74,
            "review_summary": "제안, 운영 디바이스 가리지 않고 다양한 업무의 경험과 뒷받침 되는 엄청난 포트폴리오를 쌓을 수 있다. 특히나 뉴미디어 쪽으로의 경험과 커리어를 쌓고 싶다면 강추",
            "interview_question": "자기소개, 지원동기, 영어 가능여부, 기존 작업한 문서를 토대로 PT",
            "salary_avg": 2909,
            "update_date": "2022-02-01T11:04:31.000+09:00"
        },
        {
            "cell_type": "CELL_TYPE_HORIZONTAL_THEME",
            "count": 9,
            "section_title": "인기 급상승 공고",
            "recommend_recruit": [
                {
                    "id": 1200,
                    "title": "[잡플래닛] iOS 앱개발",
                    "reward": 2000000,
                    "appeal": "복지포인트, 스낵바, 자기계발비",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2229/w750__EA_B8_B0_ED_9A_8D_ED_8C_80.jpg",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                        "ratings": [
                            {
                                "type": "사내문화",
                                "rating": 3.6
                            },
                            {
                                "type": "워라밸",
                                "rating": 3.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 3.5
                            }
                        ]
                    }
                },
                {
                    "id": 1201,
                    "title": "[잡플래닛] Android 앱개발",
                    "reward": 0,
                    "appeal": "복지포인트100만원, 유연근무제, 단일호칭, 자율출퇴근, 패밀리데이",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2126/w750__EC_95_88_EB_93_9C_EB_A1_9C_EC_9D_B4_EB_93_9C_1400_788.png",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                        "ratings": [
                            {
                                "type": "경영진",
                                "rating": 2.0
                            },
                            {
                                "type": "CEO 지지도",
                                "rating": 4.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 3.5
                            }
                        ]
                    }
                },
                {
                    "id": 1203,
                    "title": "[잡플래닛] 프론트 엔드 개발자 (Senior)",
                    "reward": 100000,
                    "appeal": "복지포인트100만원, 유연근무제, 단일호칭, 자율출퇴근, 패밀리데이",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2125/w750__ED_94_84_EB_A1_A0_ED_8A_B8_EC_97_94_EB_93_9C_ED_8C_80_1400_788.png",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                        "ratings": [
                            {
                                "type": "경영진",
                                "rating": 2.0
                            },
                            {
                                "type": "CEO 지지도",
                                "rating": 4.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 4.1
                            }
                        ]
                    }
                },
                {
                    "id": 1100,
                    "title": "기술전문 상담사",
                    "reward": 0,
                    "appeal": "",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/88038/thumb______.jpg",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/88038/thumb______.jpg",
                        "ratings": [
                            {
                                "type": "사내문화",
                                "rating": 0.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 0.0
                            },
                            {
                                "type": "승진 가능성",
                                "rating": 0.0
                            }
                        ]
                    }
                },
                {
                    "id": 1205,
                    "title": "[잡플래닛] 백엔드 개발자 (Junior)",
                    "reward": 500000,
                    "appeal": "패밀리데이, 최신업무장비 복지포인트 100만원, 재택근무, 복지카드, 자율출퇴근",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2117/w750__EB_B0_B1_EC_97_94_EB_93_9C_ED_8C_80_1400_788.png",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                        "ratings": [
                            {
                                "type": "사내문화",
                                "rating": 2.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 3.0
                            },
                            {
                                "type": "승진 가능성",
                                "rating": 4.1
                            }
                        ]
                    }
                },
                {
                    "id": 110,
                    "title": "[잡플래닛] QA 엔지니어 팀장",
                    "reward": 1000000,
                    "appeal": "재택근무, 복지카드, 자율출퇴근, 패밀리데이",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2113/w750_QA_ED_8C_80_1400_788.png",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                        "ratings": [
                            {
                                "type": "사내문화",
                                "rating": 3.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 3.0
                            },
                            {
                                "type": "CEO 지지도",
                                "rating": 3.0
                            }
                        ]
                    }
                },
                {
                    "id": 1010,
                    "title": "[잡플래닛] 마케팅 제휴 본부장",
                    "reward": 100000,
                    "appeal": "최신업무장비 복지포인트 100만원, 재택근무, 복지카드, 자율출퇴근, 패밀리데이",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2113/w750_QA_ED_8C_80_1400_788.png",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                        "ratings": [
                            {
                                "type": "사내문화",
                                "rating": 3.1
                            },
                            {
                                "type": "복지/급여",
                                "rating": 3.0
                            },
                            {
                                "type": "승진 가능성",
                                "rating": 3.0
                            }
                        ]
                    }
                },
                {
                    "id": 1300,
                    "title": "사내 변호사(Junior)",
                    "reward": 0,
                    "appeal": "재택근무, 복지카드, 패밀리데이",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/957/w750_00.thumbnail.png",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                        "ratings": [
                            {
                                "type": "사내문화",
                                "rating": 4.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 4.1
                            },
                            {
                                "type": "승진 가능성",
                                "rating": 4.0
                            }
                        ]
                    }
                },
                {
                    "id": 1301,
                    "title": "전략제휴본부 서비스 운영 기획/관리 담당자",
                    "reward": 0,
                    "appeal": "",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/88038/thumb______.jpg",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/88038/thumb______.jpg",
                        "ratings": [
                            {
                                "type": "사내문화",
                                "rating": 4.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 4.0
                            },
                            {
                                "type": "승진 가능성",
                                "rating": 4.1
                            }
                        ]
                    }
                }
            ]
        },
        {
            "cell_type": "CELL_TYPE_COMPANY",
            "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/60172/thumb___________.png",
            "name": "유라코퍼레이션(주)",
            "industry_name": "제조/화학",
            "rate_total_avg": 2.77,
            "review_summary": "글로벌한 근무환경과 다양한 직무경험 보수적인 분위기",
            "interview_question": "1차) 자기소개와 함께 지원하신 동기 말씀해주세요.\n      와이어링 설계에서 무엇이 중요하다고 생각하나\n      그외 이력서 특이사항 질문\n2차) 학교에서 무엇을 배웠나? \n        또는 학교에서 무엇을 하였는가?\n        ",
            "salary_avg": 4047,
            "update_date": "2022-07-01T19:01:11.000+09:00"
        },
        {
            "cell_type": "CELL_TYPE_COMPANY",
            "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/56099/thumb_56099.JPG",
            "name": "젬스메디컬(주)",
            "industry_name": "제조/화학",
            "rate_total_avg": 2.38,
            "review_summary": "개발/연구 등 많은 투자를 통해서 DR시스템업체로 발돋움을 하려고 하였으나 경영진의 이원화 및 집중화 부족으로 예측할 수 없는 상황",
            "interview_question": "1. 업무 관련 지식에 대한 질문\r\n2. 협업과 관련된 사람들을 대하는 태도 질문\r\n3. 할 수 있는 일과 하고 싶은 일\r\n4. 본인의 장단점에 관한 질문",
            "salary_avg": 3067,
            "update_date": "2022-06-01T12:01:01.000+09:00"
        },
        {
            "cell_type": "CELL_TYPE_REVIEW",
            "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/6991/thumb_____35.PNG",
            "name": "퀄컴씨디엠에이테크날러지코리아(유)",
            "industry_name": "유통/무역/운송",
            "rate_total_avg": 4.25,
            "review_summary": "자기가 한만큼 인정 받고 대접을 받을 수 있는 곳",
            "cons": "지사로써의 한계. 모든 결정 및 책임은 본사로부터 나옴. 너무 비용만을 고려한 의사결정은 회사에 대한 충성도를 떨어 뜨림",
            "pros": "매니저의 눈치를 거의 안보고 업무만 집중할 수 있는 분위기. 높은 수준의 연봉. 업계 최고의 기술력을 보유하고 있음. 체계화된 프로세스등 배울 것이 많음. 해외의 유능한 엔지니어와의 소통을 통해 느끼고 배울수 있는 기회",
            "update_date": "2022-06-01T11:01:11.000+09:00"
        },
        {
            "cell_type": "CELL_TYPE_COMPANY",
            "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/3247/thumb_________.png",
            "name": "한국원자력의학원",
            "industry_name": "기관/협회",
            "rate_total_avg": 3,
            "review_summary": "교통이 괜찮고 넉넉한 근무, 하지만 챗바퀴 도는 기분",
            "interview_question": "지원하는 직무에 본인이 적합한 이유를 설명하시오.\n지원하는 직무가 하는일을 설명하시오.",
            "salary_avg": 3209,
            "update_date": "2022-05-02T07:01:11.000+09:00"
        },
        {
            "cell_type": "CELL_TYPE_COMPANY",
            "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86149/thumb____.png",
            "name": "가비아(주)",
            "industry_name": "IT/웹/통신",
            "rate_total_avg": 3.41,
            "review_summary": "매너리즘 심각함, 부서에 따라서 업무량과 부담이 확 다름.",
            "interview_question": "고객이 홈페이지를 제작하고 싶어한다. 어떻게 응대를 하겠느냐 ",
            "salary_avg": 3357,
            "update_date": "2022-05-05T20:01:11.000+09:00"
        },
        {
            "cell_type": "CELL_TYPE_REVIEW",
            "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/2679/thumb_2679.png",
            "name": "한미반도체(주)",
            "industry_name": "제조/화학",
            "rate_total_avg": 2.37,
            "review_summary": "반도체 후공정 장비 1위 인지도는 있음",
            "cons": "고객의 니즈에 맞춰 제품 제작이 이루어져 관련 기술응용 함에 좋으나 표준 제품 제작보다 시간이 좀 더 투입됨.",
            "pros": "반도체 관련 산업 전망에 대해 이해할 수 있으며 이름도 알려져 있어 커리어 관리하기에는 좋음.",
            "update_date": "2022-02-02T20:01:10.000+09:00"
        },
        {
            "cell_type": "CELL_TYPE_COMPANY",
            "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/60632/thumb_______.png",
            "name": "위메프(주)",
            "industry_name": "유통/무역/운송",
            "rate_total_avg": 2.53,
            "review_summary": "AMD도 MD가 될 수 있는 기회가 열린 곳. 열정을 높이 사는 곳, 신입 분들에게 권합니다. 매우 빠르게 성장하면서 성장통을 겪고 있는 회사. 과도한 업무, 체계 부족이 문제이지만 문제 개선을 위해 노력하는 회사.",
            "interview_question": "1. 전 직장에서 했던 일\r\n2. 위메프에 입사하려는 이유\r\n3. 성취한 일, 실패한 일. 교훈",
            "salary_avg": 2828,
            "update_date": "2022-05-05T19:12:12.000+09:00"
        },
        {
            "cell_type": "CELL_TYPE_COMPANY",
            "logo_path": "https://jpassets.jobplanet.co.kr/assets/default_logo_share-12e4cb8f87fe87d4c2316feb4cb33f42d7f7584f2548350d6a42e47688a00bd0.png",
            "name": "미래디자인아이엠씨(주)",
            "industry_name": "미디어/디자인",
            "rate_total_avg": 0,
            "review_summary": "",
            "interview_question": "전에 직장에서 무슨업무를 했었는가 연봉은 얼마정도 생각하는가 압박질문은 없었다. 부모님께서 무슨 일하시나 물어보시며 비웃으셨다......",
            "salary_avg": 0,
            "update_date": "2022-07-07T20:11:11.000+09:00"
        },
        {
            "cell_type": "CELL_TYPE_REVIEW",
            "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/3585/thumb_3585.png",
            "name": "한국미니스톱(주)",
            "industry_name": "유통/무역/운송",
            "rate_total_avg": 2.52,
            "review_summary": "전형적인 일본식회사. 한국 특유의 매출압박은 없으나,상여금 및 명절떡값도 없음 (개인주의가 심해서 특유의  소속감 부재)",
            "cons": "명절 상여금x. 소프트크림및 치킨을 팔아서 관리하는데 손이 자주감 . 승진하려면 일본어 잘해야되서 이직률도 높은듯",
            "pros": "돈은 많이주는편. 초봉이 세금띠고 3250정도 되는듯. 6개월 점장생활을 거친뒤, 15개 매장을 관리한다. 편의점 숫자는 전국4등이지만 점포당 매출액은 1위",
            "update_date": "2021-12-21T19:02:11.000+09:00"
        },
        {
            "cell_type": "CELL_TYPE_HORIZONTAL_THEME",
            "count": 9,
            "section_title": "인기 급상승 중인 잡플래닛의 추천 공고",
            "recommend_recruit": [
                {
                    "id": 1200,
                    "title": "[잡플래닛] iOS 앱개발",
                    "reward": 2000000,
                    "appeal": "복지포인트, 스낵바, 자기계발비",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2229/w750__EA_B8_B0_ED_9A_8D_ED_8C_80.jpg",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                        "ratings": [
                            {
                                "type": "사내문화",
                                "rating": 3.6
                            },
                            {
                                "type": "워라밸",
                                "rating": 3.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 3.5
                            }
                        ]
                    }
                },
                {
                    "id": 1201,
                    "title": "[잡플래닛] Android 앱개발",
                    "reward": 0,
                    "appeal": "복지포인트100만원, 유연근무제, 단일호칭, 자율출퇴근, 패밀리데이",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2126/w750__EC_95_88_EB_93_9C_EB_A1_9C_EC_9D_B4_EB_93_9C_1400_788.png",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                        "ratings": [
                            {
                                "type": "경영진",
                                "rating": 2.0
                            },
                            {
                                "type": "CEO 지지도",
                                "rating": 4.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 3.5
                            }
                        ]
                    }
                },
                {
                    "id": 1203,
                    "title": "[잡플래닛] 프론트 엔드 개발자 (Senior)",
                    "reward": 100000,
                    "appeal": "복지포인트100만원, 유연근무제, 단일호칭, 자율출퇴근, 패밀리데이",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2125/w750__ED_94_84_EB_A1_A0_ED_8A_B8_EC_97_94_EB_93_9C_ED_8C_80_1400_788.png",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                        "ratings": [
                            {
                                "type": "경영진",
                                "rating": 2.0
                            },
                            {
                                "type": "CEO 지지도",
                                "rating": 4.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 4.1
                            }
                        ]
                    }
                },
                {
                    "id": 1100,
                    "title": "기술전문 상담사",
                    "reward": 0,
                    "appeal": "",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/88038/thumb______.jpg",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/88038/thumb______.jpg",
                        "ratings": [
                            {
                                "type": "사내문화",
                                "rating": 0.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 0.0
                            },
                            {
                                "type": "승진 가능성",
                                "rating": 0.0
                            }
                        ]
                    }
                },
                {
                    "id": 1205,
                    "title": "[잡플래닛] 백엔드 개발자 (Junior)",
                    "reward": 500000,
                    "appeal": "패밀리데이, 최신업무장비 복지포인트 100만원, 재택근무, 복지카드, 자율출퇴근",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2117/w750__EB_B0_B1_EC_97_94_EB_93_9C_ED_8C_80_1400_788.png",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                        "ratings": [
                            {
                                "type": "사내문화",
                                "rating": 2.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 3.0
                            },
                            {
                                "type": "승진 가능성",
                                "rating": 4.1
                            }
                        ]
                    }
                },
                {
                    "id": 110,
                    "title": "[잡플래닛] QA 엔지니어 팀장",
                    "reward": 1000000,
                    "appeal": "재택근무, 복지카드, 자율출퇴근, 패밀리데이",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2113/w750_QA_ED_8C_80_1400_788.png",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                        "ratings": [
                            {
                                "type": "사내문화",
                                "rating": 3.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 3.0
                            },
                            {
                                "type": "CEO 지지도",
                                "rating": 3.0
                            }
                        ]
                    }
                },
                {
                    "id": 1010,
                    "title": "[잡플래닛] 마케팅 제휴 본부장",
                    "reward": 100000,
                    "appeal": "최신업무장비 복지포인트 100만원, 재택근무, 복지카드, 자율출퇴근, 패밀리데이",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/2113/w750_QA_ED_8C_80_1400_788.png",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                        "ratings": [
                            {
                                "type": "사내문화",
                                "rating": 3.1
                            },
                            {
                                "type": "복지/급여",
                                "rating": 3.0
                            },
                            {
                                "type": "승진 가능성",
                                "rating": 3.0
                            }
                        ]
                    }
                },
                {
                    "id": 1300,
                    "title": "사내 변호사(Junior)",
                    "reward": 0,
                    "appeal": "재택근무, 복지카드, 패밀리데이",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company_story/thumbnail/957/w750_00.thumbnail.png",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/86783/thumb_thumb_jp_symbol3.png",
                        "ratings": [
                            {
                                "type": "사내문화",
                                "rating": 4.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 4.1
                            },
                            {
                                "type": "승진 가능성",
                                "rating": 4.0
                            }
                        ]
                    }
                },
                {
                    "id": 1301,
                    "title": "전략제휴본부 서비스 운영 기획/관리 담당자",
                    "reward": 0,
                    "appeal": "",
                    "image_url": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/88038/thumb______.jpg",
                    "company": {
                        "name": "잡플래닛",
                        "logo_path": "https://jpassets.jobplanet.co.kr/production/uploads/company/logo/88038/thumb______.jpg",
                        "ratings": [
                            {
                                "type": "사내문화",
                                "rating": 4.0
                            },
                            {
                                "type": "복지/급여",
                                "rating": 4.0
                            },
                            {
                                "type": "승진 가능성",
                                "rating": 4.1
                            }
                        ]
                    }
                }
            ]
        },
        {
            "cell_type": "CELL_TYPE_COMPANY",
            "logo_path": "https://jpassets.jobplanet.co.kr/assets/default_logo_share-12e4cb8f87fe87d4c2316feb4cb33f42d7f7584f2548350d6a42e47688a00bd0.png",
            "name": "시내엔들(주)",
            "industry_name": "유통/무역/운송",
            "rate_total_avg": 0,
            "review_summary": "",
            "interview_question": "편안한 분위기에서 불편한 질문들, 사적인 질문 많음. 압박면접이라 생각하면 괜찮으나 개인적으로 불편했음. 나중엔 속으로 '에라 모르겠다 나 뽑든말든 맘대로해라'라는 심보가 자라남. ",
            "salary_avg": 0,
            "update_date": "2020-02-02T19:02:20.000+09:00"
        }
    ]
}
```

<div align="center">
  <img src="https://github.com/user-attachments/assets/420690b9-486e-49fd-b630-40367c398727" width="400">
</div>

<br>

4. 검색 기능
> UserDefaults를 통해 사용자가 최근 검색한 검색어 순으로 정렬하고 검색어들을 전체삭제하는 기능들을 삽입, 추가적으로 결과를 보여줄때는 고차함수 filter를 이용하여 화면단에 최종적으로 보여짐

```swift
import Foundation
import ReactorKit

final class SearchResultReactor: Reactor {
    var initialState = State()
    private let apiService = MainService.shared
    
    struct State {
        var keyword: String = ""
        var recruitItem: [RecruitItem]? = nil
        var enterpriseItem: [CellItem]? = nil
    }
    
    enum Action {
        case viewWillAppear(keyword: String)
    }
    
    enum Mutation {
        case setKeyword(keyword: String)
        case setRecruit([RecruitItem])
        case setEnterprise([CellItem])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear(let keyword):
            return Observable.concat([
                .just(.setKeyword(keyword: keyword)),
                apiService.fetchData(.employment, model: Recruit.self)
                    .map { .setRecruit($0.recruitItems) },
                apiService.fetchData(.enterprise, model: Enterprise.self)
                    .map { .setEnterprise($0.cellItems) }
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setKeyword(let keyword):
            newState.keyword = keyword
        case .setRecruit(let recruit):
            newState.recruitItem = recruit.filter { $0.title.contains(state.keyword) }
        case .setEnterprise(let cellItem):
            newState.enterpriseItem = cellItem
                .filter { $0.cellType == .cellTypeCompany || $0.cellType == .cellTypeReview }
                .filter { $0.name?.contains(state.keyword) ?? false }
            
        }
        return newState
    }
}

```

<div align="center">
  <img src="https://github.com/user-attachments/assets/1d21785a-3ce0-43da-98ba-aa4897d74fc5" width="400">
</div>

<br>


## 5. 개발 기간 및 작업 관리

### 개발 기간

- 전체 개발 기간 : 2024-11-04 ~ 2024-11-11
- 기능 구현 : 2024-11-04 ~ 2024-11-11

<br>

## 6. 신경 쓴 부분

1. 검색 기능
> 검색 기능은 잡플래닛에서 자유롭게 구현하라고 제시한 기능으로 신경쓴 부분은 **최근 검색어**, **최근 검색어 전체 삭제**, **검색 결과** 등이 있습니다.
> 최근 검색어 관련은 UserDefaults를 사용하여 구현하였습니다.


```swift
// TODO: 1. 중복 없이
// TODO: 2. 중복이라면 맨앞으로 뺄 것

import Foundation

final class AppUserDefaults {
    static let shared = AppUserDefaults()
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Keys
    private struct Keys {
        static let recentSearchWord = "RecentSearchWord"
    }
    
    func setRecentSearchWord(with keyword: String) {
        var searchWordArray = getRecentSearchWord()

        // 1. 중복 제거: 이미 존재하는 검색어는 제거
        if let index = searchWordArray.firstIndex(of: keyword) {
            searchWordArray.remove(at: index)
        }

        // 2. 새로운 검색어를 맨 앞에 추가
        searchWordArray.insert(keyword, at: 0)

        // UserDefaults에 저장
        UserDefaults.standard.setValue(searchWordArray, forKey: Keys.recentSearchWord)
    }

    
    func getRecentSearchWord() -> [String] {
        guard let array = userDefaults.stringArray(forKey: Keys.recentSearchWord) else {
            return []
        }
        
        return array
    }
    
    func removeRecentSearchWord() {
        userDefaults.removeObject(forKey: Keys.recentSearchWord)
    }
}
```




<div align="center">
  <img src="https://github.com/user-attachments/assets/1d21785a-3ce0-43da-98ba-aa4897d74fc5" width="400">
</div>

<br>

2. UI, MVVM, 코드정리
> 해당 주제들로 리젝이 된 프로젝트이기 때문에 해당 주제들을 더 많이 신경썼고, 자세한 내용은 프로젝트 코드를 참고 바랍니다 🙇🏻‍♂️





<br>

## 7. 개선 목표

- UIStackView로 구현된 부분이 있는데 UIStackView의 Set되는 데이터가 작아 현재 메모리에 부담은 적지만 만약 데이터가 커진다면 UICollectionView나 UITableView로 Refactoring 예정
    
<br>

## 8. 프로젝트 후기

### 🧑🏻‍💻 신승욱

> iOS 개발자로서 경험이 부족했던 시절, 이 과제는 나에게 신선한 충격을 줬다. 당시 내가 알고 있던 UIKit, 코드 정리, MVVM 패턴 개발 방식은 겉핥기에 불과해, 전형에서 탈락하고 말았다. 지금이라면 가볍게 해결할 수 있는 요구사항이었지만, 그때는 밤을 새워가며 프로젝트를 마쳤다. 그래도 그 과제 덕분에 배움의 끈을 놓지 않고 성장할 수 있었던 것 같다. 그리고 이제는 한층 성장한 나에게 박수(?)👏🏻

<br>

