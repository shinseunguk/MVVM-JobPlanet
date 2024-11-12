//
//  SearchResultReactor.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/12/24.
//

import Foundation
import ReactorKit

final class SearchResultReactor: Reactor {
    var initialState = State()
    private let apiService = MainService()
    
    struct State {
        var keyword: String = ""
        var recruitItem: [RecruitItem]? = nil
        var enterpriseItem: [CellItem]? = nil
    }
    
    enum Action {
        case viewWillAppear(keyword: String)
    }
    
    enum Mutation {
        case setKeyword(keyword: String)
        case setRecruit([RecruitItem])
        case setEnterprise([CellItem])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear(let keyword):
            return Observable.concat([
                .just(.setKeyword(keyword: keyword)),
                apiService.fetchData(.employment, model: Recruit.self)
                    .map { .setRecruit($0.recruitItems) },
                apiService.fetchData(.enterprise, model: Enterprise.self)
                    .map { .setEnterprise($0.cellItems) }
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setKeyword(let keyword):
            newState.keyword = keyword
        case .setRecruit(let recruit):
            newState.recruitItem = recruit.filter { $0.title.contains(state.keyword) }
        case .setEnterprise(let cellItem):
            newState.enterpriseItem = cellItem
                .filter { $0.cellType == .cellTypeCompany || $0.cellType == .cellTypeReview }
                .filter { $0.name?.contains(state.keyword) ?? false }
            
        }
        return newState
    }
}
