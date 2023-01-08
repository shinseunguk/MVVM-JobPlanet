//
//  EmploymentViewModel.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/08.
//

import Foundation


public class EmploymentViewModel{
    static let shared = EmploymentViewModel()
    let server = Server.shared
    
    var employmentModel : EmploymentModel? {
        didSet {
            self.didFinishFetch?()
        }
    }
    
    var didFinishFetch: (() -> ())?
    
    public func employmentReqeust(){
        server.employment { model, error in
            if let model = model {
                self.employmentModel = model
            }
        }
    }
}
