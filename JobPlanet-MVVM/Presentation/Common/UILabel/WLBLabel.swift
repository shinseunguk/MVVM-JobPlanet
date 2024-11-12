//
//  WLBLabel.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/5/24.
//

import Foundation
import UIKit

final class WLBLabel: UILabel {
    
    // 패딩 값
    var padding = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.text = title
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.JPGray03.cgColor
        self.layer.cornerRadius = 4
        
        self.font = .systemFont(ofSize: 11)
        self.textColor = .JPGray02
        self.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 패딩을 적용하여 텍스트를 그리기 위한 메서드 오버라이드
    override func drawText(in rect: CGRect) {
        let paddedRect = rect.inset(by: padding)
        super.drawText(in: paddedRect)
    }
    
    // UILabel의 크기를 조정하기 위해 intrinsicContentSize를 오버라이드
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let width = size.width + padding.left + padding.right
        let height = size.height + padding.top + padding.bottom
        return CGSize(width: width, height: height)
    }
}

