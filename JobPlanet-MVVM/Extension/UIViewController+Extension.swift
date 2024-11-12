//
//  UIViewController+Extension.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/11/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, confirmTitle: String = "확인", cancelTitle: String = "취소", confirmHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            confirmHandler?() // 확인 버튼이 눌렸을 때 실행될 작업
        }
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
