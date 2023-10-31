//
//  UserDefaultHelper.swift
//  BhagavadGeeta
//
//  Created by Devarsh Bhalara on 31/10/23.
//

import Foundation

struct Keys {
    static let currentDate = "currentDate"
    static let randomSlokEnglish = "randomSlokEnglish"
    static let randomSlokHindi = "randomSlokHindi"
    static let language = "language"
}

class UserDefaultHelper: NSObject {
    
    private override init() {
        
    }
    static let shared = UserDefaultHelper()
    
    var currentDate: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.currentDate) ?? ""
        } set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.currentDate)
            UserDefaults.standard.synchronize()
        }
    }
    
    var randomSlokEnglish: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.randomSlokEnglish) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.randomSlokEnglish)
            UserDefaults.standard.synchronize()
        }
    }
    
    var randomSlokHindi: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.randomSlokHindi) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.randomSlokHindi)
            UserDefaults.standard.synchronize()
        }
    }
    
    var language: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.language) ?? "en"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.language)
            UserDefaults.standard.synchronize()
        }
    }
}
