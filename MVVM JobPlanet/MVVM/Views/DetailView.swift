//
//  DetailView.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/09.
//

import Foundation
import UIKit

@IBDesignable
class DetailView: UIView{
    let helper = Helper()
    var model : EmploymentDetail? {
        didSet {
            print("DetailView model => \(model)")
            
            let url = URL(string: (model?.company?.logo_path!)!)
            //DispatchQueue를 쓰는 이유 -> 이미지가 클 경우 이미지를 다운로드 받기 까지 잠깐의 멈춤이 생길수 있다. (이유 : 싱글 쓰레드로 작동되기때문에)
            //DispatchQueue를 쓰면 멀티 쓰레드로 이미지가 클경우에도 멈춤이 생기지 않는다.
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
//                    cell.imageView.image = UIImage(data: data!)
                    self.companyImageView.kf.indicatorType = .activity
                    self.companyImageView.kf.setImage(
                      with: url,
                      placeholder: nil,
                      options: nil,
                      completionHandler: nil
                    )
                }
            }
            
            titleLabel.text = model?.title
            companyLabel.text = model?.company?.name
            
            if let model0 = model?.company?.ratings?[0], let model1 = model?.company?.ratings?[1], let model2 = model?.company?.ratings?[2] {
                avgTitleLabel1.text = model0.type
                ratingLabel1.text = String(describing: model0.rating!)
                
                avgTitleLabel2.text = model1.type
                ratingLabel2.text = String(describing: model1.rating!)
                
                avgTitleLabel3.text = model2.type
                ratingLabel3.text = String(describing: model2.rating!)
            }
            
            
        }
    }
    
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
    
    let view2 : UIView = {
        let view = UIView()
        return view
    }()
    
    let avgTitleLabel1 : UILabel = {
        let view = UILabel()
        view.text = "사내문화"
        view.textColor = .black
        view.font = .systemFont(ofSize: 13)
        view.sizeToFit()
        return view
    }()
    
    let ratingImageView1 : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_star")
        view.clipsToBounds = true
        return view
    }()

    let ratingLabel1 : UILabel = {
        let label = UILabel()
        label.text = "3.6"
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    let avgTitleLabel2 : UILabel = {
        let view = UILabel()
        view.text = "사내문화"
        view.textColor = .black
        view.font = .systemFont(ofSize: 13)
        view.sizeToFit()
        return view
    }()
    
    let ratingImageView2 : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_star")
        view.clipsToBounds = true
        return view
    }()

    let ratingLabel2 : UILabel = {
        let label = UILabel()
        label.text = "3.6"
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    let avgTitleLabel3 : UILabel = {
        let view = UILabel()
        view.text = "사내문화"
        view.textColor = .black
        view.font = .systemFont(ofSize: 13)
        view.sizeToFit()
        return view
    }()
    
    let ratingImageView3 : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_star")
        view.clipsToBounds = true
        return view
    }()

    let ratingLabel3 : UILabel = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(#file , #function)
        addSubview(view)
        addSubview(view2)
        view.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
        
        _ = [companyImageView, titleLabel, companyLabel].map {
            view.addSubview($0)
        }
        
        _ = [avgTitleLabel1, ratingImageView1, ratingLabel1, avgTitleLabel2, ratingImageView2, ratingLabel2, avgTitleLabel3, ratingImageView3, ratingLabel3].map {
            view2.addSubview($0)
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
        
        
        companyLabel.snp.makeConstraints{(make) in
            make.left.equalTo(companyImageView.snp.right).offset(12)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        view2.snp.makeConstraints{(make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(companyImageView.snp.bottom).offset(20)
            make.height.equalTo(100)
        }
        
        ratingImageView2.snp.makeConstraints{(make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(safeAreaLayoutGuide.snp.centerX).offset(10)
            make.width.equalTo(11)
            make.height.equalTo(10.52)
        }
        
        avgTitleLabel2.snp.makeConstraints{(make) in
            make.right.equalTo(ratingImageView2.snp.left).offset(-10)
            make.centerY.equalTo(ratingImageView2.snp.centerY)
        }
        
        ratingLabel2.snp.makeConstraints{(make) in
            make.left.equalTo(ratingImageView2.snp.right).offset(5)
            make.centerY.equalTo(ratingImageView2.snp.centerY)
        }
        
        avgTitleLabel1.snp.makeConstraints{(make) in
            make.left.equalToSuperview()
            make.centerY.equalTo(ratingImageView2.snp.centerY)
        }
        
        ratingImageView1.snp.makeConstraints{(make) in
            make.centerY.equalTo(ratingImageView2.snp.centerY)
            make.left.equalTo(avgTitleLabel1.snp.right).offset(10)
            make.width.equalTo(11)
            make.height.equalTo(10.52)
        }
        
        ratingLabel1.snp.makeConstraints{(make) in
            make.left.equalTo(ratingImageView1.snp.right).offset(5)
            make.centerY.equalTo(ratingImageView1.snp.centerY)
        }
        
        avgTitleLabel3.snp.makeConstraints{(make) in
            make.right.equalTo(ratingImageView3.snp.left).offset(-10)
            make.centerY.equalTo(ratingImageView1.snp.centerY)
        }
        
        ratingImageView3.snp.makeConstraints{(make) in
            make.right.equalTo(ratingLabel3.snp.left).offset(-5)
            make.centerY.equalTo(ratingImageView1.snp.centerY)
        }
        
        ratingLabel3.snp.makeConstraints{(make) in
            make.right.equalToSuperview()
            make.centerY.equalTo(ratingImageView1.snp.centerY)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
