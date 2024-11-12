//
//  ToggleButon.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/5/24.
//

import Foundation
import UIKit

enum PageType {
    case employment
    case enterprise
    
    var title : String {
        switch self {
        case .employment: return "채용"
        case .enterprise: return "기업"
        }
    }
}

final class ToggleButon: UIButton {
    
    init(type: PageType) {
        super.init(frame: .zero)
        
        self.setTitle(type.title, for: .normal)
        self.layer.cornerRadius = 10
        self.setTitleColor(.black, for: .normal)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggleButton(_ toggle: Bool) {
        if toggle {
            self.layer.borderWidth = 0
            self.backgroundColor = UIColor.JPGreen
            self.setTitleColor(.white, for: .normal)
        } else {
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.JPGray03.cgColor
            self.backgroundColor = .clear
            self.setTitleColor(.black, for: .normal)
        }
    }
}
