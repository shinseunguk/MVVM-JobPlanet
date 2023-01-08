//
//  EnterpriseViewModel.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/09.
//

import Foundation

public class EnterpriseViewModel{
    static let shared = EnterpriseViewModel()
    let server = Server.shared
    
    var EnterpriseModel : EnterpriseModel? {
        didSet {
            self.didFinishFetch?()
        }
    }
    
    var didFinishFetch: (() -> ())?
    
    public func enterpriseReqeust(){
        server.enterprise { model, error in
            if let model = model {
                self.EnterpriseModel = model
            }
        }
    }
}
