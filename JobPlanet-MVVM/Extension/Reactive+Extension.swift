//
//  Reactive+Extension.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/7/24.
//

import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: UIScrollView {
    var contentSize: Observable<CGSize> {
        return self.observe(CGSize.self, "contentSize")
            .compactMap { $0 } // nil을 방지하기 위해 compactMap 사용
    }
}

