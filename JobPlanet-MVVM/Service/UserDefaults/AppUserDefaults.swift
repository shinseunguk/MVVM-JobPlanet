//
//  AppUserDefaults.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/11/24.
//

// TODO: 1. 중복 없이
// TODO: 2. 중복이라면 맨앞으로 뺄 것

import Foundation

final class AppUserDefaults {
    static let shared = AppUserDefaults()
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Keys
    private struct Keys {
        static let recentSearchWord = "RecentSearchWord"
    }
    
    func setRecentSearchWord(with keyword: String) {
        var searchWordArray = getRecentSearchWord()

        // 1. 중복 제거: 이미 존재하는 검색어는 제거
        if let index = searchWordArray.firstIndex(of: keyword) {
            searchWordArray.remove(at: index)
        }

        // 2. 새로운 검색어를 맨 앞에 추가
        searchWordArray.insert(keyword, at: 0)

        // UserDefaults에 저장
        UserDefaults.standard.setValue(searchWordArray, forKey: Keys.recentSearchWord)
    }

    
    func getRecentSearchWord() -> [String] {
        guard let array = userDefaults.stringArray(forKey: Keys.recentSearchWord) else {
            return []
        }
        
        return array
    }
    
    func removeRecentSearchWord() {
        userDefaults.removeObject(forKey: Keys.recentSearchWord)
    }
}

