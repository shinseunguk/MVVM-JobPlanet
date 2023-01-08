//
//  EnterpriseView.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/07.
//

import Foundation
import UIKit

@IBDesignable
class EnterpriseView: UIView{
    let cellReuseIdentifier = "EnterpriseTableViewCell"
    let cell2ReuseIdentifier = "Enterprise2TableViewCell"
    let viewModel = EnterpriseViewModel.shared
    var model : EnterpriseModel? {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "EnterpriseTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "EnterpriseTableViewCell")
            let nib2 = UINib(nibName: "Enterprise2TableViewCell", bundle: nil)
            tableView.register(nib2, forCellReuseIdentifier: "Enterprise2TableViewCell")
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 430;
        }
    }
    
    let line : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        print(#file , #function)
        viewModel.enterpriseReqeust()
        
        viewModel.didFinishFetch = {
            self.model = self.viewModel.EnterpriseModel
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        let bundle = Bundle(for: EnterpriseView.self)
        bundle.loadNibNamed("EnterpriseView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

extension EnterpriseView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cell_items = model?.cell_items {
            return cell_items.count + 1 // 한개를 더해주는 것은 인기 급상승 공고를 위한
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var indexRow : Int = 0
        
        if indexPath.row != 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! EnterpriseTableViewCell
            
            // 인기 급상승 공고로 인한 로직
            if indexPath.row >= 3 {
                indexRow = indexPath.row - 1
            }else {
                indexRow = indexPath.row
            }
//            print(indexRow)
            
            
            if let model = model?.cell_items?[indexRow] {
                print(model.name)
                // 회사 로고
                if let logoPath = model.logoPath {
                    let url = URL(string: model.logoPath!)
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: url!)
                        DispatchQueue.main.async {
                            cell.companyImageView.kf.indicatorType = .activity
                            cell.companyImageView.kf.setImage(
                                with: url,
                                placeholder: nil,
                                options: nil,
                                completionHandler: nil
                            )
                        }
                    }
                }
                
                // 회사 명
                if let name = model.name {
                    cell.titleLabel.text = name
                }
                
                // 평점
                if let rateTotalAvg = model.rateTotalAvg {
                    cell.ratingLabel.text = String(describing: rateTotalAvg)
                }
                
                // industry_name
                if let industryName = model.industryName {
                    cell.companyLabel.text = industryName
                }
                
                // 리뷰요약
                if let reviewSummary = model.reviewSummary {
                    cell.companyDescriptionLabel.text = reviewSummary
                }
                
                // 업데이트 날짜
                if let updateDate = model.updateDate {
                    let date = updateDate.substring(from: 0, to: 9) // today 년
                    
                    cell.updateDate.text = date
                }
                
                // 평균 연봉
                if let salaryAvg = model.salaryAvg {
                    cell.avgSalary.text = String(salaryAvg.commaRepresentation)
                }
                
                // 면접 질문
                if let interviewQuestion = model.interviewQuestion {
                    cell.interviewDescription.text = interviewQuestion
                }
                    
            }
            
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cell2ReuseIdentifier, for: indexPath) as! Enterprise2TableViewCell
            if let model = model?.cell_items?[indexRow].recommendRecruit {
                cell.param = model
            }
            
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != 2 {
            return 430
        }else {
            return 315
//            return 30
        }
    }
    
    
}
