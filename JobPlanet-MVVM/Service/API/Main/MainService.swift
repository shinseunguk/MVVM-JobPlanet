//
//  MainService.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/6/24.
//

import Foundation
import Moya
import RxSwift

final class MainService {
    let provider = MoyaProvider<MainRouter>()
    
    func fetchData<T: Decodable>(_ type: MainRouter, model: T.Type) -> Observable<T> {
        return Observable.create { observer in
            self.provider.request(type) { result in
                switch result {
                case .success(let response):
                    do {
                        let json = try JSONDecoder().decode(T.self, from: response.data)
                        observer.onNext(json)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
