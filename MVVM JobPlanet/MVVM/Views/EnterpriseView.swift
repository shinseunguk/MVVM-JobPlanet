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
    @IBOutlet var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
        print(#file , #function)
        backgroundColor = .cyan
    }
    
    private func commonInit(){
        let bundle = Bundle(for: EnterpriseView.self)
        bundle.loadNibNamed("EnterpriseView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
