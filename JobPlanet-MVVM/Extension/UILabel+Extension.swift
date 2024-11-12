//
//  UILabel+Extension.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/5/24.
//

import UIKit

extension UILabel {
    /// UILabel의 텍스트에 원하는 line height를 적용하는 메서드
    func setLineHeight(_ lineHeight: CGFloat) {
        guard let text = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - self.font.lineHeight
        paragraphStyle.lineBreakMode = self.lineBreakMode // 말줄임표 유지
        
        let attributedString: NSMutableAttributedString
        if let currentAttributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: currentAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: text)
        }
        
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.font, value: self.font as Any, range: NSRange(location: 0, length: attributedString.length))
        
        self.attributedText = attributedString
    }
}

