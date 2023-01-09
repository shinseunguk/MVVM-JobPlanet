//
//  EnterpriseView.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/07.
//

import Foundation
import UIKit

@IBDesignable
class EnterpriseView: UIView, PushScreen{
    func pushScreen(_ model: EmploymentDetail) {
        self.delegate?.pushScreen(model)
    }
    
    weak var delegate: PushScreen?
    weak var pushDelegate : PushParam?
    
    let cellReuseIdentifier = "EnterpriseTableViewCell"
    let cell2ReuseIdentifier = "Enterprise2TableViewCell"
    let viewModel = EnterpriseViewModel.shared
    
    var model : EnterpriseModel? {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            self.pushDelegate?.moveParam(nil, model)
        }
    }
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "EnterpriseTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "EnterpriseTableViewCell")
            let nib2 = UINib(nibName: "Enterprise2TableViewCell", bundle: nil)
            tableView.register(nib2, forCellReuseIdentifier: "Enterprise2TableViewCell")
            tableView.backgroundColor = .white
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
            return cell_items.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // collectionview
        if let model = self.model?.cell_items?[indexPath.row], let recommendRecruit = self.model?.cell_items?[indexPath.row].recommendRecruit{
            let cell = tableView.dequeueReusableCell(withIdentifier: cell2ReuseIdentifier, for: indexPath) as! Enterprise2TableViewCell
            cell.delegate = self
            cell.selectionStyle = .none
            
            
            cell.param = [model]
            return cell
        }else if let model = self.model?.cell_items?[indexPath.row]{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! EnterpriseTableViewCell
            cell.selectionStyle = .none
            
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
                    
            
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let recommendRecruit = self.model?.cell_items?[indexPath.row].recommendRecruit else{
            return 450
        }
        return 315
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.model?.cell_items?[indexPath.row].recommendRecruit == nil {
            print(indexPath.row)
        }
    }
}
