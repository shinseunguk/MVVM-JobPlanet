//
//  MainRouter.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/6/24.
//

import Moya
import Foundation

enum MainRouter: TargetType {
    case employment
    case enterprise
    
    var baseURL: URL {
        return URL(string: "https://jpassets.jobplanet.co.kr/mobile-config")!
    }
    
    var path: String {
        switch self {
        case .employment:
            return "/test_data_recruit_items.json"
        case .enterprise:
            return "/test_data_cell_items.json"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
