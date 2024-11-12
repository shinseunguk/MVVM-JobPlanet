//
//  ViewAttributes.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/4/24.
//

import Foundation

protocol ViewAttributes {
    // Optional Functions
    func setupNavigationBar()
    
    // Required Functions
    func setupSubViews()
    func setupLayouts()
    func setupBindingRx()
}

extension ViewAttributes {
    func setupNavigationBar() {}
}
