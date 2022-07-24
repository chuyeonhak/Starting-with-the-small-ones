//
//  UserDefaultsManager.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/24.
//

import Foundation

enum UserDefaultKeys: String {
    case greatestWinningStreak
    case currentWinningStreak
}

struct UserDefaultsManager {
    static var shared = UserDefaultsManager()
    
    var greatestWinningStreak: Int {
        get {
            guard let greatestWinningStreak = UserDefaults.standard.value(forKey: UserDefaultKeys.greatestWinningStreak.rawValue) as? Int else { return 0 }
            return greatestWinningStreak
        }
        set {
            UserDefaults.standard.set(newValue, forKey:  UserDefaultKeys.greatestWinningStreak.rawValue)
        }
    }
    
    var currentWinningStreak: Int {
        get {
            guard let currentWinningStreak = UserDefaults.standard.value(forKey: UserDefaultKeys.currentWinningStreak.rawValue) as? Int else { return 0 }
            return currentWinningStreak
        }
        set {
            UserDefaults.standard.set(newValue, forKey:  UserDefaultKeys.currentWinningStreak.rawValue)
        }
    }
}
