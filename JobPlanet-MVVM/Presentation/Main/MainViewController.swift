//
//  MainViewController.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/4/24.
//

import UIKit
import ReactorKit
import SnapKit
import RxSwift
import Then
import RxCocoa
import RxViewController

class MainViewController: UIViewController, ViewAttributes, UIScrollViewDelegate {
    
    private var disposeBag = DisposeBag()
    private let reactor = MainReactor()
    
    // SearchView
    private let searchView = UIView()
    private let symbolImageView = UIImageView().then {
        $0.image = UIImage(named: "img_logo_search")
    }
    
    private let searchButton = UIButton().then {
        $0.contentHorizontalAlignment = .leading
        $0.configurationUpdateHandler = { button in
            var container = AttributeContainer()
            container.font = .system(size: 17, weight: .regular)
            container.foregroundColor = UIColor.JPGray02
            var configuration = UIButton.Configuration.plain()
            configuration.baseBackgroundColor = .white
            configuration.attributedTitle = AttributedString("기업, 채용공고 검색", attributes: container)
            button.configuration = configuration
        }
    }
    
    private let divisionView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.JPGreen.cgColor
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.layer.borderColor = UIColor.red.cgColor
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
    }
    
    // employment, enterprise
    private let eeView = UIView()
    
    private let employmentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let numberOfItemsPerRow: CGFloat = 2
        let spacing: CGFloat = 20
        let totalSpacing = (numberOfItemsPerRow - 1) * spacing
        
        let width = (UIScreen.main.bounds.width - totalSpacing) / numberOfItemsPerRow
        layout.itemSize = CGSize(width: width - 20, height: 246)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.isScrollEnabled = false
            $0.backgroundColor = .white
            $0.register(EmploymentCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        }
    }()
    
    private let enterpriseTableView = UITableView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.JPGray03.cgColor
        $0.separatorStyle = .none
        $0.estimatedRowHeight = 400 // 예측하는 셀 높이
        $0.rowHeight = UITableView.automaticDimension // 자동 크기 계산
        $0.register(CompanyTableViewCell.self, forCellReuseIdentifier: "CompanyCell")
        $0.register(ThemeTableViewCell.self, forCellReuseIdentifier: "ThemeCell")
        $0.register(ReviewTableViewCell.self, forCellReuseIdentifier: "ReviewCell")
    }
    
    private let employmentButton = ToggleButon(type: .employment)
    private let enterpriseButton = ToggleButon(type: .enterprise)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubViews()
        setupLayouts()
        setupBindingRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
}

extension MainViewController {
    func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupSubViews() {
        self.view.backgroundColor = .white
        
        [
            searchView,
            divisionView,
            scrollView
        ].forEach { self.view.addSubview($0) }
        
        scrollView.addSubview(stackView)
        
        // SearchView
        [
            symbolImageView,
            searchButton
        ].forEach { self.searchView.addSubview($0) }
        
        // employment, enterprise
        [
            employmentButton,
            enterpriseButton
        ].forEach { self.eeView.addSubview($0) }
        
        // Add eeView and collectionView to stackView
        [
            eeView,
            employmentCollectionView
        ].forEach { stackView.addArrangedSubview($0) }
    }
    
    func setupLayouts() {
        // searchView
        searchView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        divisionView.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        symbolImageView.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(20)
        }
        
        searchButton.snp.makeConstraints {
            $0.leading.equalTo(symbolImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalTo(0)
        }
        
        // scrollView
        scrollView.snp.makeConstraints {
            $0.top.equalTo(divisionView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // stackView inside scrollView
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width) // stackView의 폭을 scrollView와 동일하게 설정
        }
        
        // eeView
        eeView.snp.makeConstraints {
            $0.height.equalTo(62)
        }
        
        employmentButton.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(30)
            $0.leading.equalTo(20)
            $0.centerY.equalToSuperview()
        }
        
        enterpriseButton.snp.makeConstraints {
            $0.width.height.equalTo(employmentButton)
            $0.leading.equalTo(employmentButton.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setupBindingRx() {
        searchButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.pushViewController(SearchInputViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.pageType }
            .do(onNext: {
                self.togglePageType($0)
            })
            .map { $0 == .employment }
            .subscribe(onNext: { [weak self] in
                self?.employmentButton.toggleButton($0)
                self?.enterpriseButton.toggleButton(!$0)
            })
            .disposed(by: disposeBag)
        
        rx.viewWillAppear.withLatestFrom(reactor.state.map { $0.pageType })
            .map { MainReactor.Action.tapPageType(type: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        employmentButton.rx.tap.withLatestFrom(reactor.state.map { $0.pageType })
            .filter { $0 != .employment }  // 현재 pageType이 employment가 아닌 경우만 처리 (중복 서버 요청을 막기 위함)
            .map { _ in MainReactor.Action.tapPageType(type: .employment) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        enterpriseButton.rx.tap.withLatestFrom(reactor.state.map { $0.pageType })
            .filter { $0 != .enterprise }  // 현재 pageType이 enterprise가 아닌 경우만 처리 (중복 서버 요청을 막기 위함)
            .map { _ in MainReactor.Action.tapPageType(type: .enterprise) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.recruit?.recruitItems }
            .observe(on:MainScheduler.asyncInstance)
            .bind(to: employmentCollectionView.rx.items(cellIdentifier: "CollectionViewCell", cellType: EmploymentCollectionViewCell.self)) { row, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.enterprise?.cellItems }
            .observe(on:MainScheduler.asyncInstance)
            .bind(to: enterpriseTableView.rx.items) { (tableView: UITableView, row: Int, item: CellItem) in
                let indexPath = IndexPath(row: row, section: 0)
                
                switch item.cellType {
                case .cellTypeCompany:
                    // 회사 정보 셀을 생성하여 구성
                    let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyTableViewCell
                    cell.configure(with: item)
                    return cell
                    
                case .cellTypeHorizontalTheme:
//                    // 테마형 정보 셀을 생성하여 구성
                    guard let recruit = item.recommendRecruit else {
                        return UITableViewCell()
                    }
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell", for: indexPath) as! ThemeTableViewCell
                    cell.configure(with: recruit)
                    return cell
                case .cellTypeReview:
                    // 리부형 정보 세을 생성하여 구성
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewTableViewCell
                    cell.configure(with: item)
                    return cell
                }
            }
            .disposed(by: disposeBag)
        
        // contentSize에 맞춰 employmentCollectionView의 높이 업데이트
        employmentCollectionView.rx.contentSize
            .observe(on:MainScheduler.asyncInstance)
            .map { $0.height }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] height in
                self?.employmentCollectionView.snp.updateConstraints {
                    $0.height.equalTo(height)
                }
                // 레이아웃 강제 업데이트
                self?.view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
        
        enterpriseTableView.rx.contentSize
            .observe(on:MainScheduler.asyncInstance)
            .map { $0.height }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] height in
                self?.enterpriseTableView.snp.updateConstraints {
                    $0.height.equalTo(height)
                }
                // 레이아웃 강제 업데이트
                self?.view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
    }
    
    func togglePageType(_ type: PageType) {
        switch type {
        case .employment:
            stackView.removeArrangedSubview(enterpriseTableView)
            stackView.addArrangedSubview(employmentCollectionView)
        case .enterprise:
            stackView.removeArrangedSubview(employmentCollectionView)
            stackView.addArrangedSubview(enterpriseTableView)
        }
    }
}

