//
//  MainReactor.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/5/24.
//

import Foundation
import ReactorKit

final class MainReactor: Reactor {
    var initialState = State()
    
    var apiService = MainService()
    
    struct State {
        var pageType: PageType = .employment
        var recruit: Recruit? = nil
        var enterprise: Enterprise? = nil
    }
    
    enum Action {
        case tapPageType(type: PageType)
    }
    
    enum Mutation {
        case setPageType(PageType)
        case setRecruit(Recruit)
        case setEnterprise(Enterprise)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapPageType(let type):
            switch type {
            case .employment:
                return Observable.concat([
                    .just(.setPageType(type)),
                    apiService.fetchData(.employment, model: Recruit.self)
                        .map { .setRecruit($0) }
                ])
            case .enterprise:
                return Observable.concat([
                    .just(.setPageType(type)),
                    apiService.fetchData(.enterprise, model: Enterprise.self)
                        .map { .setEnterprise($0) }
                ])
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setPageType(let pageType):
            newState.pageType = pageType
        case .setRecruit(let recruit):
            newState.recruit = recruit
        case .setEnterprise(let enterprise):
            newState.enterprise = enterprise
        }
        
        return newState
    }
}
