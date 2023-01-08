//
//  InteractionView.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/08.
//

import Foundation
import UIKit

@IBDesignable
class InteractionView: UIView{
    @IBOutlet var view: UIView!
    
    let employmentView = EmploymentView(frame: .zero)
    let enterpriseView = EnterpriseView(frame: .zero)
    
    
//    @IBOutlet weak var employmentView: EmploymentView!
//    @IBOutlet weak var enterpriseView: EnterpriseView!
    
    @IBOutlet weak var label: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(#file , #function)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print(#file , #function)
        commonInit()
        
        addSubview(employmentView)
        employmentView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func commonInit(){
        print(#file , #function)
        let bundle = Bundle(for: EmploymentView.self)
        bundle.loadNibNamed("InteractionView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func removeEmploymentView() {
        employmentView.removeFromSuperview()
        
        addSubview(enterpriseView)
        enterpriseView.snp.makeConstraints{(make) in
            make.top.left.right.bottom.equalTo(0)
        }
    }
    
    func removeEnterpriseView() {
        enterpriseView.removeFromSuperview()
        
        addSubview(employmentView)
        employmentView.snp.makeConstraints{(make) in
            make.top.left.right.bottom.equalTo(0)
        }
    }
}
