//
//  SearchViewController.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/09.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    let screenWidth = UIScreen.main.bounds.width
    
    var employmentModel : EmploymentModel?
    var enterpriseModel : EnterpriseModel?
    
    let view2 = SearchView()
    
    let searchBar : UISearchBar = {
        let view = UISearchBar()
        view.tintColor = .black
        view.placeholder = "기업, 채용공고 검색"
        return view
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
        
        self.navigationItem.titleView = searchBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(popView))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        
        searchBar.delegate = self
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {

            textfield.attributedPlaceholder = NSAttributedString(string: "기업, 채용공고 검색", attributes: [NSAttributedString.Key.foregroundColor : UIColor.placeholderColor])

            textfield.textColor = UIColor.black

            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.placeholderColor
            }
        }
        
        view2.employmentModel = self.employmentModel
        view2.enterpriseModel = self.enterpriseModel
        
        self.view.addSubview(view2)
        view2.snp.makeConstraints{(make) in
            make.left.right.top.equalTo(0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: false)
    }

    // MARK: - Search Bar text 전달
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            view2.search(text)
        }
    }
}

