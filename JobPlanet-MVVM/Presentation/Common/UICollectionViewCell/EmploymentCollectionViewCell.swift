//
//  EmploymentCollectionViewCell.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/5/24.
//

import UIKit
import SnapKit
import Kingfisher

final class EmploymentCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textAlignment = .left
        $0.numberOfLines = 2
        $0.setLineHeight(24)
    }
    
    private let ratingIconImageView = UIImageView().then {
        $0.image = UIImage(named: "icon_star")
    }
    
    private let ratingLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textAlignment = .left
    }
    
    private let companyLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .medium)
        $0.textAlignment = .left
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let rewardLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .medium)
        $0.textAlignment = .left
    }
    
    var labelArr : [UILabel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    }
}

extension EmploymentCollectionViewCell {
    private func setupSubviews() {
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.addSubview(imageView)
        
        [
            imageView,
            titleLabel,
            ratingIconImageView,
            ratingLabel,
            companyLabel,
            stackView,
            rewardLabel
        ].forEach { contentView.addSubview($0) }
    }
    
    private func setupLayouts() {
        imageView.snp.makeConstraints {
            $0.top.equalTo(7)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(98.0 / 160.0)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(imageView)
        }
        ratingIconImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(7)
            $0.leading.equalTo(titleLabel)
            $0.width.height.equalTo(12)
        }
        ratingLabel.snp.makeConstraints {
            $0.centerY.equalTo(ratingIconImageView)
            $0.leading.equalTo(ratingIconImageView.snp.trailing).offset(6)
        }
        companyLabel.snp.makeConstraints {
            $0.centerY.equalTo(ratingIconImageView)
            $0.leading.equalTo(ratingLabel.snp.trailing).offset(6)
        }
    }
    
    // 데이터를 셀에 설정하는 함수
    // TODO: WLB
    func configure(with item: RecruitItem) {
        self.imageView.kf.setImage(with: URL(string: item.imageUrl))
        
        self.titleLabel.text = item.title
        self.ratingLabel.text = setAverageRating(item.company.ratings)
        self.companyLabel.text = item.company.name
        
        if item.reward != 0 {
            self.rewardLabel.text = "축하금 \(item.reward.formattedWithCommas)"
        }
        
        self.setAppeal(with: item.appeal)
    }
    
    func setAverageRating(_ ratings: [Rating]) -> String {
        var sum: Double = 0.0
        
        for ratings in ratings {
            sum += ratings.rating
        }
        
        return String(format: "%.1f", sum / Double(ratings.count))
    }
    
    func setAppeal(with appeal: String) {
        let appeal = appeal.split(separator: ",").compactMap { String($0) }.map {
            if $0.contains(" ") {
                return $0.replacingOccurrences(of: " ", with: "")
            } else {
                return $0
            }
        }
        
        if appeal.isEmpty {
            rewardLabel.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.top.equalTo(companyLabel.snp.bottom).offset(6)
            }
        } else { // 복지가 1개 이상
            let wlbLabel = WLBLabel(title: appeal[0])
            contentView.addSubview(wlbLabel)
            
            wlbLabel.snp.makeConstraints {
                $0.top.equalTo(ratingLabel.snp.bottom).offset(10)
                $0.leading.equalToSuperview()
            }
            
            rewardLabel.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.top.equalTo(wlbLabel.snp.bottom).offset(6)
            }
        }
    }
}
