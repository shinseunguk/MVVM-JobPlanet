//
//  SearchView.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/09.
//

import Foundation
import UIKit

class SearchView: UIView {
    let cell1ReuseIdentifier = "Search1TableViewCell"
    let cell2ReuseIdentifier = "Search2TableViewCell"

    var enterpriseModel : EnterpriseModel?
    var employmentModel : EmploymentModel?
    
    var resultEnter : [EnterpriseList] = []
    var resultEmploy : [EmploymentDetail] = []

    
    
    
    lazy var tableView1 : UITableView = {
        let view = UITableView()
        view.register(Search1TableViewCell.self, forCellReuseIdentifier: cell1ReuseIdentifier)
        return view
    }()
    
    lazy var tableView2 : UITableView = {
        let view = UITableView()
        view.register(Search2TableViewCell.self, forCellReuseIdentifier: cell2ReuseIdentifier)
        return view
    }()
    
    let view = UIView()
    
    let label : UILabel = {
        let label = UILabel()
        label.text = "기업 혹은 채용공고를 검색하세요."
        return label
    }()
    
    let enterpriseLabel : UILabel = {
        let label = UILabel()
        label.text = "기업"
        label.textColor = .jpgray02
        label.sizeToFit()
        return label
    }()
    
    let enterpriseCount : UILabel = {
        let label = UILabel()
        label.textColor = .jpGreen
        label.sizeToFit()
        return label
    }()
    
    let employmentLabel : UILabel = {
        let label = UILabel()
        label.text = "채용공고"
        label.textColor = .jpgray02
        label.sizeToFit()
        return label
    }()
    
    let employmentCount : UILabel = {
        let label = UILabel()
        label.textColor = .jpGreen
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(view)
        view.snp.makeConstraints{(make) in
            make.left.right.top.equalTo(0)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(label)
        label.snp.makeConstraints{(make) in
            make.centerY.centerX.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func search(_ sender: String){
        // employmentModel -> 채용기준 검색 title, company.name
        if let model = employmentModel?.recruit_items {
            
            for x in 0 ... model.count - 1 {
                
                if let title = model[x].title, let name = model[x].company?.name {
                    
                    if title.contains(sender) || name.contains(sender) {
                        resultEmploy.append(model[x])
                    }
                }
                
            }
            
        }
        
        // enterpriseModel -> 기업기준 검색 name
        if let model = enterpriseModel?.cell_items {
            
            for x in 0 ... model.count - 1 {
                
                if let name = model[x].name {
                    
                    if name.contains(sender) {
                        resultEnter.append(model[x])
                    }
                }
            }
        }
    
        resultFunc()
    }
    
    func resultFunc(){
        print("resultEnter ", resultEnter)
        print("resultEmploy ", resultEmploy)
        
        if resultEnter.count != 0 && resultEmploy.count != 0 { // 기업 O && 채용 O
            label.alpha = 0.0
            enterpriseCount.text = String(resultEnter.count)
            employmentCount.text = String(resultEmploy.count)
            _ = [enterpriseLabel, enterpriseCount, tableView1, employmentLabel, employmentCount, tableView2].map {
                $0.removeFromSuperview()
            }

            _ = [enterpriseLabel, enterpriseCount, tableView1, employmentLabel, employmentCount, tableView2].map {
                view.addSubview($0)
            }

            enterpriseLabel.snp.makeConstraints{(make) in
                make.left.equalTo(20)
                make.top.equalTo(20)
            }

            enterpriseCount.snp.makeConstraints{(make) in
                make.centerY.equalTo(enterpriseLabel.snp.centerY)
                make.left.equalTo(enterpriseLabel.snp.right).offset(10)
            }

            tableView1.snp.makeConstraints{(make) in
                make.top.equalTo(enterpriseLabel.snp.bottom).offset(10)
                make.left.right.equalToSuperview()
                make.height.equalTo(280)
            }

            employmentLabel.snp.makeConstraints{(make) in
                make.left.equalTo(20)
                make.top.equalTo(tableView1.snp.bottom).offset(40)
            }

            employmentCount.snp.makeConstraints{(make) in
                make.centerY.equalTo(employmentLabel.snp.centerY)
                make.left.equalTo(employmentLabel.snp.right).offset(10)
            }

            tableView2.snp.makeConstraints{(make) in
                make.top.equalTo(employmentLabel.snp.bottom).offset(10)
                make.left.right.equalToSuperview()
                make.height.equalTo(280)
            }

        }else if resultEnter.count != 0 && resultEmploy.count == 0 { // 기업 O && 채용 X
            enterpriseCount.text = String(resultEnter.count)

            label.alpha = 0.0
            _ = [enterpriseLabel, enterpriseCount, tableView1, employmentLabel, employmentCount, tableView2].map {
                $0.removeFromSuperview()
            }

            _ = [enterpriseLabel, enterpriseCount, tableView1].map {
                view.addSubview($0)
            }


            enterpriseLabel.snp.makeConstraints{(make) in
                make.left.equalTo(20)
                make.top.equalTo(20)
            }

            enterpriseCount.snp.makeConstraints{(make) in
                make.centerY.equalTo(enterpriseLabel.snp.centerY)
                make.left.equalTo(enterpriseLabel.snp.right).offset(10)
            }

            tableView1.snp.makeConstraints{(make) in
                make.top.equalTo(enterpriseLabel.snp.bottom).offset(10)
                make.left.right.equalToSuperview()
                make.height.equalTo(280)
            }
        }else if resultEnter.count == 0 && resultEmploy.count != 0 { // 기업 X && 채용 O
            label.alpha = 0.0
            _ = [enterpriseLabel, enterpriseCount, tableView1, employmentLabel, employmentCount, tableView2].map {
                $0.removeFromSuperview()
            }
            employmentCount.text = String(resultEmploy.count)

            _ = [employmentLabel, employmentCount, tableView2].map {
                view.addSubview($0)
            }


            employmentLabel.snp.makeConstraints{(make) in
                make.left.equalTo(20)
                make.top.equalTo(20)
            }

            employmentCount.snp.makeConstraints{(make) in
                make.centerY.equalTo(employmentLabel.snp.centerY)
                make.left.equalTo(employmentLabel.snp.right).offset(10)
            }

            tableView2.snp.makeConstraints{(make) in
                make.top.equalTo(employmentLabel.snp.bottom).offset(10)
                make.left.right.equalToSuperview()
                make.height.equalTo(280)
            }
        }else { // 기업 X && 채용 X
            _ = [enterpriseLabel, enterpriseCount, tableView1, employmentLabel, employmentCount, tableView2].map {
                $0.removeFromSuperview()
            }
            label.alpha = 1.0
            label.text = "검색결과가 없습니다."
            label.snp.makeConstraints{(make) in
                make.centerY.centerX.equalToSuperview()
            }
        }
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        footer.backgroundColor = .white

        let footerLabel = UILabel(frame: footer.bounds)
        footerLabel.text = "전체보기"
        footerLabel.textColor = .systemBlue
        footer.addSubview(footerLabel)
        footerLabel.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let footer2 = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        footer2.backgroundColor = .white

        let footerLabel2 = UILabel(frame: footer2.bounds)
        footerLabel2.text = "전체보기"
        footerLabel2.textColor = .systemBlue
        footer2.addSubview(footerLabel2)
        footerLabel2.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        tableView1.tableFooterView = footer
        tableView2.tableFooterView = footer2
        
        tableView1.dataSource = self
        tableView1.delegate = self
        tableView1.reloadData()
        
        tableView2.dataSource = self
        tableView2.delegate = self
        tableView2.reloadData()
    }
    
}

extension SearchView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView1 {
            if resultEnter.count > 3 {
                return 3
            }else {
                return resultEnter.count
            }
        }else if tableView == self.tableView2 {
            if resultEmploy.count > 3 {
                return 3
            }else {
                return resultEmploy.count
            }
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cell1ReuseIdentifier, for: indexPath) as! Search1TableViewCell

            // 회사 로고
            let url = URL(string: resultEnter[indexPath.row].logoPath!)
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
            
            cell.titleLabel.text = resultEnter[indexPath.row].name
            cell.ratingLabel.text = String(describing: resultEnter[indexPath.row].rateTotalAvg!)
            cell.companyLabel.text = resultEnter[indexPath.row].industryName
            
            if indexPath.row == 2 {
                resultEnter = []
            }
            return cell
        }else if tableView == self.tableView2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cell2ReuseIdentifier, for: indexPath) as! Search2TableViewCell
            var ratingAvg = ratingAVG(resultEmploy[indexPath.row].company?.ratings)
            
            // 회사 로고
            let url = URL(string: (resultEmploy[indexPath.row].company?.logo_path!)!)
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
            
            cell.titleLabel.text = resultEmploy[indexPath.row].title
            cell.ratingLabel.text = ratingAvg
            cell.companyLabel.text = resultEmploy[indexPath.row].company?.name
            
            if indexPath.row == 2 {
                resultEmploy = []
            }
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - rating 평균내기
    func ratingAVG(_ ratingDetail : [ratingDetail]?) -> String{
        var avg = 0.0
        if let ratingDetail = ratingDetail {
            for x in 0...ratingDetail.count-1 {
//                print("rating => ",ratingDetail[x].rating)
                avg += ratingDetail[x].rating!
            }
            avg = avg / CGFloat(ratingDetail.count)
            
            return String(round(avg))
        }else {
            return "0.0"
        }
    }
    
    
}
