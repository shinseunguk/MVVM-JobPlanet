//
//  ThemeTableViewCell.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/7/24.
//

import Foundation
import UIKit
import RxSwift

final class ThemeTableViewCell: UITableViewCell {
    
    private var disposeBag = DisposeBag()
    
    private let popularityEmploymentTitle = UILabel().then {
        $0.text = "인기 급상승 채용 공고"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .JPGray01
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
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .white
            $0.register(EmploymentCollectionViewCell.self, forCellWithReuseIdentifier: "EmployCollectionViewCell")
        }
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        setupSubViews()
        setupLayouts()
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ThemeTableViewCell {
    func setupSubViews() {
        [
            popularityEmploymentTitle,
            employmentCollectionView
        ].forEach { contentView.addSubview($0) }
    }
    
    func setupLayouts() {
        popularityEmploymentTitle.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        employmentCollectionView.snp.makeConstraints {
            $0.top.equalTo(popularityEmploymentTitle.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(230)
            $0.bottom.equalTo(-20)
        }
    }
    
    func configure(with recruitItem: [RecruitItem]) {
        Observable.just(recruitItem)
            .bind(to: employmentCollectionView.rx.items(cellIdentifier: "EmployCollectionViewCell", cellType: EmploymentCollectionViewCell.self)) { row, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
    }
}
