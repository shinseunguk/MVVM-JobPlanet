//
//  Search1TableViewCell.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/09.
//

import UIKit

class Search1TableViewCell: UITableViewCell {
    
    let companyImageView : UIImageView = {
        let view = UIImageView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.jpgray03.cgColor
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "ㅈㅍㄹㄴ"
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
        label.text = "3.6"
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    let companyLabel : UILabel = {
        let label = UILabel()
        label.text = "IT/웹/통신"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tableViewInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableViewInit(){
        _ = [companyImageView, titleLabel, ratingImageView, ratingLabel, companyLabel].map {
            addSubview($0)
        }
        
        companyImageView.snp.makeConstraints{(make) in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.height.width.equalTo(58)
        }
        
        titleLabel.snp.makeConstraints{(make) in
            make.top.equalTo(27)
            make.left.equalTo(companyImageView.snp.right).offset(12)
        }
        
        ratingImageView.snp.makeConstraints{(make) in
            make.left.equalTo(companyImageView.snp.right).offset(12)
            make.width.equalTo(11)
            make.height.equalTo(10.56)
            make.top.equalTo(titleLabel.snp.bottom).offset(9.25)
        }
        
        ratingLabel.snp.makeConstraints{(make) in
            make.left.equalTo(ratingImageView.snp.right).offset(4.5)
            make.centerY.equalTo(ratingImageView.snp.centerY)
        }
        
        companyLabel.snp.makeConstraints{(make) in
            make.left.equalTo(ratingLabel.snp.right).offset(9)
            make.centerY.equalTo(ratingImageView.snp.centerY)
        }
    }

}
