//
//  Server.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/08.
//

import Foundation
import Alamofire

class Server {
    static let shared = Server()
    
    let URL = "https://jpassets.jobplanet.co.kr/mobile-config"
    
    func employment(completion : @escaping (EmploymentModel?, Error?) -> ()){
        let url = URL + "/test_data_recruit_items.json"
        print("url => \(url)")
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json; charset=utf-8", "Accept":"application/json"])
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let result = response.data else {return}
                do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(EmploymentModel.self, from: response.data!)
                
                completion(json, nil)
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                print("🚫 @@Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                completion(nil, error)
            }
        }
    }
}
