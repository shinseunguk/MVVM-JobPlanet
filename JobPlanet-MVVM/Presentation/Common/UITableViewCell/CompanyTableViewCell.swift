//
//  CompanyTableViewCell.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/7/24.
//

import Foundation
import UIKit
import Kingfisher

final class CompanyTableViewCell: UITableViewCell {
    
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
    
    // 평균 연봉
    private let salaryAvgView = UIView()
    private let salaryAvgTitleLabel = UILabel().then {
        $0.text = "평균연봉"
        $0.textColor = .JPGreen
        $0.font = .systemFont(ofSize: 17, weight: .light)
    }
    
    private let salaryAvgMoneyLabel = UILabel().then {
        $0.textColor = .JPGray01
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    private let currencyUnitLabel = UILabel().then {
        $0.text = "만원"
        $0.textColor = .JPGray01
        $0.font = .systemFont(ofSize: 11, weight: .regular)
    }
    
    // 면접 질문
    private let interViewQuestionTitleLabel = UILabel().then {
        $0.text = "면접 질문"
        $0.font = .systemFont(ofSize: 17, weight: .bold)
        $0.textColor = .JPGray01
    }
    
    private let interviewQuestionContentLabel = UILabel().then {
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
        self.salaryAvgMoneyLabel.text = ""
        self.interviewQuestionContentLabel.text = ""
    }
    
    func configure(with item: CellItem) {
        // 회사 로고 ,회사이름, 직종, 평점
        self.companyLogoImageView.kf.setImage(with: URL(string: item.logoPath ?? ""))
        self.companyLabel.text = item.name ?? ""
        self.industryNameLabel.text = item.industryName ?? ""
        self.ratingLabel.text = String(format: "%.1f", item.rateTotalAvg ?? "0.0")
        
        // 회사 리뷰
        self.companyReviewLabel.text = item.reviewSummary ?? ""
        
        // 연봉
        self.salaryAvgMoneyLabel.text = item.salaryAvg?.formattedWithCommas
        
        // 면접 질문
        self.interviewQuestionContentLabel.text = item.interviewQuestion ?? ""
        interviewQuestionContentLabel.setLineHeight(25)
    }
}

extension CompanyTableViewCell {
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
            salaryAvgView,
            currencyUnitLabel,
            interViewQuestionTitleLabel,
            interviewQuestionContentLabel,
            divisionBorderView
        ].forEach { self.contentView.addSubview($0)/*; $0.layer.borderWidth = 1*/ }
        
        [
            salaryAvgTitleLabel,
            salaryAvgMoneyLabel,
            currencyUnitLabel
        ].forEach { self.salaryAvgView.addSubview($0) }
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
        // 평균연봉
        salaryAvgView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
            $0.top.equalTo(companyReviewLabel.snp.bottom).offset(20)
        }
        salaryAvgTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        salaryAvgMoneyLabel.snp.makeConstraints {
            $0.leading.equalTo(salaryAvgTitleLabel.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        currencyUnitLabel.snp.makeConstraints {
            $0.leading.equalTo(salaryAvgMoneyLabel.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
        }
        interViewQuestionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(salaryAvgView.snp.bottom).offset(20)
            $0.leading.equalTo(20)
        }
        interviewQuestionContentLabel.snp.makeConstraints {
            $0.top.equalTo(interViewQuestionTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        divisionBorderView.snp.makeConstraints {
            $0.top.equalTo(interviewQuestionContentLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(0)
        }
    }
}

