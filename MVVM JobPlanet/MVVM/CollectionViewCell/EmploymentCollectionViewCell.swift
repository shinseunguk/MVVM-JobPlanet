//
//  EmploymentCollectionViewCell.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/08.
//

import UIKit

class EmploymentCollectionViewCell: UICollectionViewCell {
    
    var id : Int?
    
    let halfWidth = UIScreen.main.bounds.width / 2
    
    let imageView : UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    let ratingImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_star")
        view.clipsToBounds = true
        return view
    }()
    
    let ratingLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    let companyLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    let appealLabel1 : UILabel = {
        let label = PaddingLabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        label.sizeToFit()
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.init(red: 229/255, green: 230/255, blue: 233/255, alpha: 1).cgColor
        label.layer.cornerRadius = 4
        return label
    }()
    
    let appealLabel2 : UILabel = {
        let label = PaddingLabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        label.sizeToFit()
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.init(red: 229/255, green: 230/255, blue: 233/255, alpha: 1).cgColor
        label.layer.cornerRadius = 4
        return label
    }()
    
    let rewardLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .white
        
        _ = [imageView, titleLabel, ratingImageView, ratingLabel, companyLabel, appealLabel1, appealLabel2, rewardLabel].map {
            addSubview($0)
        }
        
        imageView.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(halfWidth - 40)
            make.height.equalTo((halfWidth - 40) * 0.61)
        }
        
        titleLabel.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.height.equalTo(48)
        }
        
        ratingImageView.snp.makeConstraints{(make) in
            make.left.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(5.75)
            make.width.equalTo(11)
            make.height.equalTo(10.52)
        }
        
        ratingLabel.snp.makeConstraints{(make) in
            make.centerY.equalTo(ratingImageView.snp.centerY)
            make.left.equalTo(ratingImageView.snp.right).offset(4.5)
        }
        
        companyLabel.snp.makeConstraints{(make) in
            make.centerY.equalTo(ratingImageView.snp.centerY)
            make.left.equalTo(ratingLabel.snp.right).offset(4)
        }
        
        appealLabel1.snp.makeConstraints{(make) in
            make.left.equalToSuperview()
            make.top.equalTo(ratingLabel.snp.bottom).offset(5)
        }
        
        appealLabel2.snp.makeConstraints{(make) in
            make.left.equalTo(appealLabel1.snp.right).offset(4)
            make.centerY.equalTo(appealLabel1.snp.centerY)
        }
        
        rewardLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview()
            make.top.equalTo(ratingImageView.snp.bottom).offset(40)
        }
        
    }

}
