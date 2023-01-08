//
//  EnterpriseTableViewCell.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/08.
//

import UIKit

class EnterpriseTableViewCell: UITableViewCell {
    let helper = Helper()
    
    let view : UIView = {
        let view = UIView()
        return view
    }()
    
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
    
    let line : UIView = {
        let view = UIView()
        view.backgroundColor = .jpgray03
        return view
    }()
    
    let doubleQuotation : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_quote")
        view.clipsToBounds = true
        return view
    }()
    
    let updateDate : UILabel = {
        let view = UILabel()
        view.text = "2022.12.20"
        view.textColor = .jpgray03
        view.font = .systemFont(ofSize: 13)
        view.sizeToFit()
        return view
    }()
    
    lazy var companyDescriptionLabel : UILabel = {
        let view = UILabel()
        view.text = "경력대비 연봉이 높고 업무환경이 꺠끗하게 잘조성되어 있음. 직원들이 전부 여유로워서 쓸데 없는 감정소모와 마찰이 없음"
        view.textColor = .jpgray01
        view.font = .boldSystemFont(ofSize: 18)
        view.numberOfLines = 0
        view.sizeToFit()
        view.lineBreakMode = .byCharWrapping
        helper.lineSpacing(view, 5) // line간격
        return view
    }()
    
    let avgSalaryDescription : UILabel = {
        let view = UILabel()
        view.text = "평균연봉"
        view.textColor = .jpGreen
        view.font = .systemFont(ofSize: 17)
        view.sizeToFit()
        return view
    }()
    
    let avgSalary : UILabel = {
        let view = UILabel()
        view.text = "4,123"
        view.textColor = .jpgray01
        view.font = .boldSystemFont(ofSize: 24)
        view.sizeToFit()
        return view
    }()
    
    let avgSalaryLabel : UILabel = {
        let view = UILabel()
        view.text = "만원"
        view.textColor = .jpgray01
        view.font = .systemFont(ofSize: 17)
        view.sizeToFit()
        return view
    }()
    
    let interviewLabel : UILabel = {
        let view = UILabel()
        view.text = "면접질문"
        view.textColor = .jpgray01
        view.font = .boldSystemFont(ofSize: 17)
        view.sizeToFit()
        return view
    }()
    
    lazy var interviewDescription : UILabel = {
        let view = UILabel()
        view.text = "경력대비 연봉이 높고 업무환경이 꺠끗하게 잘조성되어 있음. 직원들이 전부 여유로워서 쓸데 없는 감정소모와 마찰이 없음"
        view.textColor = .jpgray01
        view.font = .systemFont(ofSize: 17)
        view.sizeToFit()
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        helper.lineSpacing(view, 5)
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print(#file , #function)
        
        backgroundColor = .white

        _ = [companyImageView, titleLabel, ratingImageView, ratingLabel, companyLabel, line, doubleQuotation, updateDate, companyDescriptionLabel, avgSalaryDescription, avgSalary, avgSalaryLabel, interviewLabel, interviewDescription].map {
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
        
        line.snp.makeConstraints{(make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(1)
            make.top.equalTo(line.snp.bottom).offset(20)
        }
        
        doubleQuotation.snp.makeConstraints{(make) in
            make.left.equalTo(20)
            make.height.width.equalTo(22)
            make.top.equalTo(companyImageView.snp.bottom).offset(25)
        }
        
        updateDate.snp.makeConstraints{(make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(doubleQuotation.snp.centerY)
        }
        
        companyDescriptionLabel.snp.makeConstraints{(make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(doubleQuotation.snp.bottom).offset(14)
        }
        
        avgSalaryDescription.snp.makeConstraints{(make) in
            make.left.equalTo(20)
            make.top.equalTo(companyDescriptionLabel.snp.bottom).offset(19)
        }
        
        avgSalary.snp.makeConstraints{(make) in
            make.left.equalTo(avgSalaryDescription.snp.right).offset(8)
            make.centerY.equalTo(avgSalaryDescription.snp.centerY)
        }
        
        avgSalaryLabel.snp.makeConstraints{(make) in
            make.left.equalTo(avgSalary.snp.right).offset(4)
            make.centerY.equalTo(avgSalary.snp.centerY)
        }
        
        interviewLabel.snp.makeConstraints{(make) in
            make.left.equalTo(20)
            make.top.equalTo(avgSalaryDescription.snp.bottom).offset(25)
        }
        
        interviewDescription.snp.makeConstraints{(make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(interviewLabel.snp.bottom).offset(10)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.jpgray03.cgColor
    }
    
}
