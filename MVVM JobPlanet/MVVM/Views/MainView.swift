//
//  MainView.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/07.
//

import Foundation
import UIKit

@IBDesignable
class MainView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var interActionView: InteractionView!
    @IBOutlet weak var employmentBtn: UIButton! {
        didSet {
            employmentBtn.tag = 1
            employmentBtn.addTarget(self, action: #selector(tabMan(_:)), for: .touchUpInside)
            employmentBtn.backgroundColor = UIColor.jpGreen
            employmentBtn.tintColor = .white
            employmentBtn.titleLabel?.font = .boldSystemFont(ofSize: 15)
            employmentBtn.layer.cornerRadius = 15
            employmentBtn.layer.borderWidth = 1
            employmentBtn.layer.borderColor = UIColor.init(red: 229/255, green: 230/255, blue: 233/255, alpha: 1).cgColor
        }
        
    }
    @IBOutlet weak var enterpriseBtn: UIButton! {
        didSet {
            enterpriseBtn.tag = 2
            enterpriseBtn.addTarget(self, action: #selector(tabMan(_:)), for: .touchUpInside)
            enterpriseBtn.backgroundColor = UIColor.white
            enterpriseBtn.tintColor = .black
            enterpriseBtn.titleLabel?.font = .boldSystemFont(ofSize: 15)
            enterpriseBtn.layer.cornerRadius = 15
            enterpriseBtn.layer.borderWidth = 1
            enterpriseBtn.layer.borderColor = UIColor.init(red: 229/255, green: 230/255, blue: 233/255, alpha: 1).cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        let bundle = Bundle(for: MainView.self)
        bundle.loadNibNamed("MainView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @objc func tabMan(_ sender: Any){
        
        let btnTag = (sender as? UIButton)?.tag
        guard let btnTag = btnTag else {return}
        
        switch btnTag {
            case 1:
                changeView(true)
            break
            case 2:
                changeView(false)
            break
            default:
                print("default")
            }
        
    }
    
    func changeView(_ change: Bool){
        if change {
            employmentBtn.backgroundColor = UIColor.jpGreen
            employmentBtn.tintColor = .white
            enterpriseBtn.backgroundColor = UIColor.white
            enterpriseBtn.tintColor = .black
            
            interActionView.removeEnterpriseView()
        }else{
            employmentBtn.backgroundColor = UIColor.white
            employmentBtn.tintColor = .black
            enterpriseBtn.backgroundColor = UIColor.jpGreen
            enterpriseBtn.tintColor = .white
            
            interActionView.removeEmploymentView()
        }
    }
    
}
