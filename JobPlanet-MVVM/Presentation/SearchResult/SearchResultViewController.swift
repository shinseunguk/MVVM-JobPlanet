//
//  SearchResultViewController.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/11/24.
//

import Foundation
import UIKit
import RxSwift

final class SearchResultViewController: UIViewController, ViewAttributes {
    
    private let reactor = SearchResultReactor()
    private var disposeBag = DisposeBag()
    private var keyword: String?
    
    private let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let contentView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let employmentView = UIView()
    private let enterpriseView = UIView()
    private let employmentTitleLabel = UILabel().then {
        $0.text = "채용 공고"
        $0.textColor = .JPGray02
    }
    
    private let employmentCountLabel = UILabel().then {
        $0.textColor = .JPGreen
    }
    
    private let employmentEmptyLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.alpha = 0
    }
    
    private let employmentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let numberOfItemsPerRow: CGFloat = 2
        let spacing: CGFloat = 20
        let totalSpacing = (numberOfItemsPerRow - 1) * spacing
        
        let width = (UIScreen.main.bounds.width - totalSpacing) / numberOfItemsPerRow
        layout.itemSize = CGSize(width: width - 20, height: 246)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout.scrollDirection = .horizontal
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .systemBlue
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .white
            $0.register(EmploymentCollectionViewCell.self, forCellWithReuseIdentifier: "EmploymentCollectionViewCell")
        }
    }()
    
    private let enterpriseStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    private let enterpriseTitleLabel = UILabel().then {
        $0.text = "기업"
        $0.textColor = .JPGray02
    }
    
    private let enterpriseCountLabel = UILabel().then {
        $0.textColor = .JPGreen
    }
    
    private let enterpriseEmptyLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.alpha = 0
    }
    
    init(keyword: String) {
        self.keyword = keyword
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupNavigationBar()
        setupSubViews()
        setupLayouts()
        setupBindingRx()
    }
}

extension SearchResultViewController {
    func setupNavigationBar() {
        self.title = keyword ?? ""
    }
    
    func setupSubViews() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            employmentView,
            enterpriseView
        ].forEach { contentView.addSubview($0) }
        
        [
            employmentTitleLabel,
            employmentCountLabel,
            employmentCollectionView,
            employmentEmptyLabel
        ].forEach { employmentView.addSubview($0) }
        
        [
            enterpriseTitleLabel,
            enterpriseCountLabel,
            enterpriseStackView,
            enterpriseEmptyLabel
        ].forEach { enterpriseView.addSubview($0) }
        
        enterpriseStackView.layer.borderColor = UIColor.red.cgColor
    }
    
    func setupLayouts() {
        // scrollView와 contentView에 대한 제약 설정
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.frameLayoutGuide)  // 가로 고정, 세로는 스크롤 가능하도록
        }
        
        // employmentView 및 enterpriseView에 대한 제약 설정
        employmentView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(280)
        }
        
        // employmentView 내부 레이아웃 설정
        employmentTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(20)
        }
        
        employmentCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(employmentTitleLabel)
            $0.leading.equalTo(employmentTitleLabel.snp.trailing).offset(6)
        }
        
        employmentCollectionView.snp.makeConstraints {
            $0.top.equalTo(employmentTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        employmentEmptyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
        }
        
        // enterpriseView 및 내부 레이아웃 설정
        enterpriseView.snp.makeConstraints {
            $0.top.equalTo(employmentView.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20) // scrollView의 content size에 맞게 조정
        }
        
        enterpriseTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        enterpriseCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(enterpriseTitleLabel)
            $0.leading.equalTo(enterpriseTitleLabel.snp.trailing).offset(6)
        }
        
        enterpriseStackView.snp.makeConstraints {
            $0.top.equalTo(enterpriseTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        enterpriseEmptyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setupBindingRx() {
        rx.viewWillAppear.map { _ in SearchResultReactor.Action.viewWillAppear(keyword: self.keyword ?? "")}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.keyword }
            .subscribe(onNext: { [weak self] in
                self?.employmentEmptyLabel.text = "'\($0)'에 맞는 채용 공고가 없습니다"
                self?.enterpriseEmptyLabel.text = "'\($0)'에 맞는 기업이 없습니다"
            })
            .disposed(by: disposeBag)
        
        reactor.state.compactMap{ $0.recruitItem?.count }
            .map { "\($0)" }
            .subscribe(onNext: { [weak self] in
                self?.employmentEmptyLabel.alpha = $0 == "0" ? 1.0 : 0.0
                self?.employmentCountLabel.text = $0
            })
            .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.recruitItem }
            .observe(on:MainScheduler.asyncInstance)
            .bind(to: employmentCollectionView.rx.items(cellIdentifier: "EmploymentCollectionViewCell", cellType: EmploymentCollectionViewCell.self)) { row, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.enterpriseItem?.count }
            .map { "\($0)" }
            .subscribe(onNext: { [weak self] in
                self?.enterpriseEmptyLabel.alpha = $0 == "0" ? 1.0 : 0.0
                self?.enterpriseCountLabel.text = $0
            })
            .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.enterpriseItem }
            .subscribe(onNext: { [weak self] in
                self?.enterpriseStackView.subviews.forEach {
                    $0.removeFromSuperview()
                }
                
                for element in $0 {
                    let companyLabel = CompanyLabel(item: element)
                    
                    companyLabel.snp.makeConstraints {
                        $0.height.equalTo(90)
                    }
                    
                    self?.enterpriseStackView.addArrangedSubview(companyLabel)
                    
                }
            })
            .disposed(by: disposeBag)
    }
}
