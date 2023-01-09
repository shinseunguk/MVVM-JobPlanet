//
//  InteractionView.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/08.
//

import Foundation
import UIKit


@IBDesignable
class InteractionView: UIView, PushScreen, PushParam{
    func moveParam(_ model1: EmploymentModel?, _ model2: EnterpriseModel?) {
        print(#file , #function)
        self.pushDelegate?.moveParam(model1, model2)
    }
    
    func pushScreen(_ model: EmploymentDetail) {
        print(#file , #function)
        self.delegate?.pushScreen(model)
    }
    
    @IBOutlet var view: UIView!
    
    let employmentView = EmploymentView(frame: .zero)
    let enterpriseView = EnterpriseView(frame: .zero)
    
    weak var delegate : PushScreen?
    weak var pushDelegate : PushParam?
    
    @IBOutlet weak var label: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
        addSubview(employmentView)
        employmentView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func commonInit(){
        let bundle = Bundle(for: EmploymentView.self)
        bundle.loadNibNamed("InteractionView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        employmentView.delegate = self
        employmentView.pushDelegate = self
        enterpriseView.delegate = self
        enterpriseView.pushDelegate = self
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
