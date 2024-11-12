//
//  SearchInputViewController.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/11/24.
//

import Foundation
import UIKit
import RxSwift

final class SearchInputViewController: UIViewController, ViewAttributes {
    private var disposeBag = DisposeBag()
    private let reactor = SearchInputReactor()
    
    private let searchBar = UISearchBar().then {
        $0.placeholder = "기업, 채용공고 검색"
    }
    
    private let recentSearchView = UIView()
    private let recentSearchTitleLabel = UILabel().then {
        $0.text = "최근 검색어"
        $0.font = .systemFont(ofSize: 17, weight: .bold)
        $0.textColor = .JPGray01
    }
    
    private let deleteAllButton = UIButton(type: .system).then {
        $0.setTitle("전체삭제", for: .normal)
    }
    
    private let scrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 15
        $0.alignment = .fill
    }
    
    override func viewDidLoad() {
        setupSubViews()
        setupLayouts()
        setupBindingRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
}

extension SearchInputViewController {
    func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.titleView = searchBar
        self.navigationController?.navigationBar.tintColor = UIColor.black // 원하는 색상으로 변경
    }
    
    func setupSubViews() {
        self.view.backgroundColor = .white
        
        [
            recentSearchView,
            scrollView
        ].forEach { self.view.addSubview($0) }
        
        [
            recentSearchTitleLabel,
            deleteAllButton
        ].forEach { self.recentSearchView.addSubview($0) }
        
        [
            stackView
        ].forEach { self.scrollView.addSubview($0) }
    }
    
    func setupLayouts() {
        recentSearchView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(30)
        }
        recentSearchTitleLabel.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
        deleteAllButton.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(recentSearchView.snp.bottom).offset(20)
            $0.height.equalTo(42)
        }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    func setupBindingRx() {
        rx.viewWillAppear.map { _ in SearchInputReactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .map { self.searchBar.text?.trimmingCharacters(in: .whitespaces) ?? "" }
            .filter { !$0.isEmpty } // 공백만 있을 경우 이벤트를 막음
            .map { SearchInputReactor.Action.search(keyword: $0) }
            .subscribe(onNext: { [weak self] in
                self?.searchBar.resignFirstResponder()
                self?.reactor.action.onNext($0)
            })
            .disposed(by: disposeBag)

        deleteAllButton.rx.tap.map { _ in SearchInputReactor.Action.tapDeleteAllButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.showAlert } // showAlert가 true일 때만 실행
            .subscribe(onNext: { [weak self] _  in
                self?.showAlert(title: "알림", message: "최근 검색어를 전체 삭제 하시겠습니까?") {
                    self?.reactor.action.onNext(.tapAlertOK)
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.recentSearchWord }
            .do(onNext: { [weak self] in
                self?.recentSearchView.alpha = $0.isEmpty ? 0.0 : 1.0
            })
            .subscribe(onNext: { [weak self] in
                self?.stackView.subviews.forEach { $0.removeFromSuperview() }
                
                for (index, element) in $0.enumerated() {
                    let button = RecentSearchButton(with: element)
                    self?.stackView.addArrangedSubview(button)
                    
                    // 첫 번째 버튼에 왼쪽 마진 추가
                    if index == 0 {
                        button.snp.makeConstraints { $0.leading.equalToSuperview().offset(20) }
                    }
                    
                    // 마지막 버튼에 오른쪽 마진 추가
                    if index == $0.count - 1 {
                        button.snp.makeConstraints { $0.trailing.equalToSuperview().inset(-20) }
                    }
                    
                    button.rx.tap.map { SearchInputReactor.Action.search(keyword: element) }
                        .bind(to: self!.reactor.action)
                        .disposed(by: self!.disposeBag)
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.searchKeyword }
            .filter { $0 != "" }
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.pushViewController(SearchResultViewController(keyword: $0), animated: true)
                self?.reactor.action.onNext(.search(keyword: ""))
            })
            .disposed(by: disposeBag)
    }
}
