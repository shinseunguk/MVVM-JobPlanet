//
//  CompanyLabel.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/12/24.
//

import Foundation
import UIKit

final class CompanyLabel: UILabel {
    
    private let companyLogoImageView = UIImageView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.JPGray03.cgColor
        $0.layer.cornerRadius = 4
    }
    
    private let companyLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .JPGray01
        $0.textAlignment = .left
    }
    
    private let ratingIconImageView = UIImageView().then {
        $0.image = UIImage(named: "icon_star")
    }
    
    private let ratingLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textAlignment = .left
    }
    
    private let industryNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .medium)
        $0.textAlignment = .left
    }
    
    init(item: CellItem) {
        super.init(frame: .zero)
        
        self.companyLogoImageView.kf.setImage(with: URL(string: item.logoPath ?? ""))
        self.companyLabel.text = item.name ?? ""
        self.ratingLabel.text = String(format: "%.1f", item.rateTotalAvg ?? "0.0")
        self.industryNameLabel.text = item.industryName ?? ""
        
        setupSubViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CompanyLabel {
    func setupSubViews() {
        [
            companyLogoImageView,
            companyLabel,
            ratingIconImageView,
            ratingLabel,
            industryNameLabel
        ].forEach { addSubview($0) }
    }
    
    func setupLayouts() {
        companyLogoImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(58)
        }
        companyLabel.snp.makeConstraints {
            $0.leading.equalTo(companyLogoImageView.snp.trailing).offset(12)
            $0.top.equalTo(companyLogoImageView.snp.top).offset(7)
        }
        ratingIconImageView.snp.makeConstraints {
            $0.width.height.equalTo(12)
            $0.leading.equalTo(companyLabel)
            $0.bottom.equalTo(companyLogoImageView).offset(-5.45)
        }
        ratingLabel.snp.makeConstraints {
            $0.leading.equalTo(ratingIconImageView.snp.trailing).offset(5)
            $0.centerY.equalTo(ratingIconImageView)
        }
        industryNameLabel.snp.makeConstraints {
            $0.leading.equalTo(ratingLabel.snp.trailing).offset(3)
            $0.centerY.equalTo(ratingIconImageView)
        }
    }
}
