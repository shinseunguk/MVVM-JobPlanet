//
//  SearchInputReactor.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/11/24.
//

import Foundation
import ReactorKit

final class SearchInputReactor: Reactor {
    private let appUserDefaults = AppUserDefaults.shared
    var initialState = State()
    
    struct State {
        var searchKeyword: String?
        var recentSearchWord: [String]?
        @Pulse var showAlert: Bool = false
    }
    
    enum Action {
        case viewWillAppear
        case search(keyword: String)
        case tapDeleteAllButton
        case tapAlertOK
    }
    
    enum Mutation {
        case setRecentSearchWord
        case search(keyword: String)
        case setShowAlert
        case deleteAllRecentSearchWord
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return .just(.setRecentSearchWord)
        case .search(let keyword):
            return .just(.search(keyword: keyword))
        case .tapDeleteAllButton:
            return .just(.setShowAlert)
        case .tapAlertOK:
            return .just(.deleteAllRecentSearchWord)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setRecentSearchWord:
            newState.recentSearchWord = appUserDefaults.getRecentSearchWord()
        case .search(let keyword):
            if keyword != "" {
                appUserDefaults.setRecentSearchWord(with: keyword)
                newState.recentSearchWord = appUserDefaults.getRecentSearchWord()
            }
            newState.searchKeyword = keyword
        case .setShowAlert:
            newState.showAlert = true
        case .deleteAllRecentSearchWord:
            appUserDefaults.removeRecentSearchWord()
            newState.showAlert = false
            newState.recentSearchWord = appUserDefaults.getRecentSearchWord()
        }
        return newState
    }
}
