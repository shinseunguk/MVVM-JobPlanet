//
//  ReviewTableViewCell.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/8/24.
//

import Foundation
import UIKit
import Kingfisher

final class ReviewTableViewCell: UITableViewCell {
    
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
    
    private let divisionView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.JPGray03.cgColor
    }
    
    private let companyReviewIconImageView = UIImageView().then {
        $0.image = UIImage(named: "icon_quote")
        $0.contentMode = .scaleAspectFill
    }
    
    private let companyReviewLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.numberOfLines = 0
    }
    
    private let prosTitleLabel = UILabel().then {
        $0.text = "장점"
        $0.font = .systemFont(ofSize: 17, weight: .bold)
        $0.textColor = .JPGray01
    }
    
    private let prosContentLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 17, weight: .regular)
    }
    
    private let consTitleLabel = UILabel().then {
        $0.text = "단점"
        $0.font = .systemFont(ofSize: 17, weight: .bold)
        $0.textColor = .JPGray01
    }
    
    private let consContentLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 17, weight: .regular)
    }
    
    private let divisionBorderView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.JPGray03.cgColor
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        setupSubViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.companyLogoImageView.image = nil
        self.companyLabel.text = ""
        self.industryNameLabel.text = ""
        self.ratingLabel.text = ""
        self.companyReviewLabel.text = ""
        self.prosContentLabel.text = ""
        self.consContentLabel.text = ""
    }
    
    func configure(with item: CellItem) {
        // 회사 로고 ,회사이름, 직종, 평점
        self.companyLogoImageView.kf.setImage(with: URL(string: item.logoPath ?? ""))
        self.companyLabel.text = item.name ?? ""
        self.industryNameLabel.text = item.industryName ?? ""
        self.ratingLabel.text = String(format: "%.1f", item.rateTotalAvg ?? "0.0")
        
        // 회사 리뷰
        self.companyReviewLabel.text = item.reviewSummary ?? ""
        
        // 장단점
        self.prosContentLabel.text = item.pros ?? ""
        self.consContentLabel.text = item.cons ?? ""
    }
}

extension ReviewTableViewCell {
    func setupSubViews() {
        [
            companyLogoImageView,
            companyLabel,
            ratingIconImageView,
            ratingLabel,
            industryNameLabel,
            divisionView,
            companyReviewIconImageView,
            companyReviewLabel,
            prosTitleLabel,
            prosContentLabel,
            consTitleLabel,
            consContentLabel,
            divisionBorderView
        ].forEach { self.contentView.addSubview($0)/*; $0.layer.borderWidth = 1*/ }
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
        divisionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
            $0.top.equalTo(ratingIconImageView.snp.bottom).offset(20)
        }
        companyReviewIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22)
            $0.top.equalTo(divisionView.snp.bottom).offset(25)
            $0.width.equalTo(24)
            $0.height.equalTo(17.07)
        }
        companyReviewLabel.snp.makeConstraints {
            $0.top.equalTo(companyReviewIconImageView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        prosTitleLabel.snp.makeConstraints {
            $0.top.equalTo(companyReviewLabel.snp.bottom).offset(20)
            $0.leading.equalTo(20)
        }
        prosContentLabel.snp.makeConstraints {
            $0.top.equalTo(prosTitleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        consTitleLabel.snp.makeConstraints {
            $0.top.equalTo(prosContentLabel.snp.bottom).offset(10)
            $0.leading.equalTo(20)
        }
        consContentLabel.snp.makeConstraints {
            $0.top.equalTo(consTitleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        divisionBorderView.snp.makeConstraints {
            $0.top.equalTo(consContentLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(0)
        }
    }
}

