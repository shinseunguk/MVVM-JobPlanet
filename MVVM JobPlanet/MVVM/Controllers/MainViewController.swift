//
//  MainViewController.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/07.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, PushScreen, PushParam{
    func moveParam(_ model1: EmploymentModel?, _ model2: EnterpriseModel?) {
        print(#file , #function)
        
        if let model1 = model1 {
            self.employmentModel = model1
        }
        
        if let model2 = model2 {
            self.enterpriseModel = model2
        }
    }
    
    
    func pushScreen(_ model: EmploymentDetail) {
        let VC = DetailViewController()
        VC.model = model
        self.navigationController?.pushViewController(VC, animated: false)
    }
    
    
    var employmentModel : EmploymentModel? {
        didSet {
            print("didSet employmentModel \(employmentModel)")
        }
    }
    
    var enterpriseModel : EnterpriseModel? {
        didSet {
            print("didSet enterpriseModel \(enterpriseModel)")
        }
    }
    
    
    let screenWidth = UIScreen.main.bounds.width
    @IBOutlet weak var mainView: MainView!
    @IBOutlet weak var borderView: UIView!
    
    let view1 : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        return view
    }()
    
    lazy var textField : UIButton = {
        let textField = UIButton()
        textField.frame = CGRect(x: 0, y: 0, width: screenWidth - 110, height: 80)
        textField.backgroundColor = UIColor.clear
        textField.setTitleColor(UIColor.placeholderColor, for: .normal)
        textField.setTitle("기업, 채용공고 검색", for: .normal)
        textField.contentHorizontalAlignment = .left
        textField.addTarget(self, action: #selector(topViewAction), for: .touchUpInside)
        return textField
    }()
    
    
    let jpImage : UIButton = {
        let magnifyingGlass = UIButton()
        magnifyingGlass.setImage(UIImage(named: "img_logo_search"), for: .normal)
        magnifyingGlass.tintColor = .black
        magnifyingGlass.imageView?.contentMode = .scaleToFill
        magnifyingGlass.tag = 2
        return magnifyingGlass
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
        mainView.pushDelegate = self
        self.view.backgroundColor = .white
        
        view1.addSubview(jpImage)
        jpImage.snp.makeConstraints{(make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(10)
            make.width.equalTo(16)
            make.height.equalTo(21)
        }
    }
    
    // MARK: -  Controller 기초 Setup 네비게이션바, Border
    override func viewDidLayoutSubviews() {
        self.navigationItem.titleView = textField
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view1)
        
        borderView.backgroundColor = UIColor.jpGreen
    }
    
    @objc func topViewAction() {
        let VC = SearchViewController()
        VC.employmentModel = self.employmentModel
        VC.enterpriseModel = self.enterpriseModel
        
        self.navigationController?.pushViewController(VC, animated: false)
    }
    
}

