//
//  Helper.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/07.
//

import Foundation
import UIKit

// MARK: - 네비게이션 아이템
extension UINavigationItem {
    //  UINavigationItem+Extensions.swift
    func makeSFSymbolButton(_ target: Any?, action: Selector, uiImage: UIImage, tintColor : UIColor) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(uiImage, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.tintColor = tintColor
            
        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
        return barButtonItem
    }
}

// MARK: - 컬러 팔레트
extension UIColor {
    static let placeholderColor = UIColor.init(red: 104/255, green: 106/255, blue: 109/255, alpha: 1)
    
    //Main Color
    static let jpGreen = UIColor.init(red: 0/255, green: 195/255, blue: 98/255, alpha: 1)
    static let jpblue = UIColor.init(red: 9/255, green: 148/255, blue: 255/255, alpha: 1)
    static let jpred = UIColor.init(red: 255/255, green: 87/255, blue: 87/255, alpha: 1)
    static let jpgray01 = UIColor.init(red: 50/255, green: 52/255, blue: 56/255, alpha: 1)
    static let jpgray02 = UIColor.init(red: 104/255, green: 106/255, blue: 109/255, alpha: 1)
    static let jpgray03 = UIColor.init(red: 229/255, green: 230/255, blue: 233/255, alpha: 1)
}

// MARK: - 000의 자리마다 (,) formatting
extension Int {
    private static var commaFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    var commaRepresentation: String {
        return Int.commaFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
