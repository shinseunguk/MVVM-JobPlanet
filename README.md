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
- 작성중



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
- 작성중   

## 5. 개발 기간 및 작업 관리

### 개발 기간

- 전체 개발 기간 : 2024-11-04 ~ 2024-11-11
- 기능 구현 : 2024-11-04 ~ 2024-11-11

<br>

## 6. 신경 쓴 부분
- 작성중


<br>

## 7. 개선 목표

- UIStackView로 구현된 부분이 있는데 UIStackView의 Set되는 데이터가 작아 현재 메모리에 부담은 적지만 만약 데이터가 커진다면 UICollectionView나 UITableView로 Refactoring 예정
    
<br>

## 8. 프로젝트 후기

### 🧑🏻‍💻 신승욱

> iOS 개발자로서 경험이 부족했던 시절, 이 과제는 나에게 신선한 충격을 줬다. 당시 내가 알고 있던 UIKit, 코드 정리, MVVM 패턴 개발 방식은 겉핥기에 불과해, 전형에서 탈락하고 말았다. 지금이라면 가볍게 해결할 수 있는 요구사항이었지만, 그때는 밤을 새워가며 프로젝트를 마쳤다. 그래도 그 과제 덕분에 배움의 끈을 놓지 않고 성장할 수 있었던 것 같다. 그리고 이제는 한층 성장한 나에게 박수(?)👏🏻

<br>

