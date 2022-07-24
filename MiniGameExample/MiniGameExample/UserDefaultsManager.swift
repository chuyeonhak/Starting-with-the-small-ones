//
//  UserDefaultsManager.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/24.
//

import Foundation

enum UserDefaultKeys: String {
    case greatestWinningStreak
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
}
