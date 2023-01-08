//
//  MainViewController.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/07.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.width
    @IBOutlet weak var mainView: MainView!
    @IBOutlet weak var borderView: UIView!
    
    let view1 : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        return view
    }()
    
    lazy var textField : UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 0, width: screenWidth - 110, height: 80)
        textField.backgroundColor = UIColor.clear
        textField.textColor = .black
        textField.placeholder = "기업, 채용공고 검색"
        textField.attributedPlaceholder = NSAttributedString(string: "기업, 채용공고 검색", attributes: [NSAttributedString.Key.foregroundColor : UIColor.placeholderColor])
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
    
}

