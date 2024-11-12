//
//  RecentSearchButton.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/11/24.
//

import Foundation
import UIKit

final class RecentSearchButton: UIButton {
    
    private let iconImageView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = .black
    }
    
    private let buttonTitleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    init(with keyword: String) {
        super.init(frame: .zero)
        
        setupSubviews()
        setupLayouts()
        
        self.layer.cornerRadius = 8
        self.backgroundColor = .JPGray03
        buttonTitleLabel.text = keyword
//        self.setTitle(keyword, for: .normal)
//        self.setTitleColor(.black, for: .normal)
//        self.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
//        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular) // 폰트 크기 조정
//        self.tintColor = .black
        
        // 패딩과 텍스트-이미지 간격 조정
//        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14) // 버튼 내부 패딩
//        self.imageEdgeInsets = UIEdgeInsets(right: 8) // 이미지와 텍스트 간격
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecentSearchButton {
    func setupSubviews() {
        [
            iconImageView,
            buttonTitleLabel
        ].forEach { self.addSubview($0) }
    }
    func setupLayouts() {
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(7)
        }
        
        buttonTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(-10)
        }
    }
}

