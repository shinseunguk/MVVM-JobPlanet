//
//  DetailViewController.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/09.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    
    var model : EmploymentDetail? {
        didSet {
            lbNavTitle.text = model?.title
        }
    }
    
    let detailView = DetailView()
    
    let lbNavTitle : UILabel = {
        let title = UILabel()
        title.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        title.font = .boldSystemFont(ofSize: 20)
        title.textColor = .black
        title.sizeToFit()
        return title
    }()
    
    let view1 : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        return view
    }()
    
    let backBtnImage : UIButton = {
        let backBtnImage = UIButton()
        backBtnImage.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backBtnImage.tintColor = .black
        backBtnImage.imageView?.contentMode = .scaleToFill
        backBtnImage.tag = 2
        backBtnImage.contentMode = .scaleAspectFit
        return backBtnImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationItem.titleView = lbNavTitle
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(popView))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        
        detailView.model = model
        self.view.addSubview(detailView)
        detailView.snp.makeConstraints{(make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: false)
    }
}
