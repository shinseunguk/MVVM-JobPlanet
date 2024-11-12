//
//  Int+Extension.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/6/24.
//

import Foundation

extension Int {
    var formattedWithCommas: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

