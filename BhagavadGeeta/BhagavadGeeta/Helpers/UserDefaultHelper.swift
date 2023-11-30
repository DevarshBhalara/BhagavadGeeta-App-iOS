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
    
    static let lastReadVerseHindi = "lastReadVerseHindi"
    static let lastReadVerseEnglish = "lastReadVerseEnglish"
    static let lastReadChapter = "lastReadChapter"
    static let lastReadVerseNum = "lastReadVerseNum"
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
    
    var lastReadVerseHindi: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.lastReadVerseHindi) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.lastReadVerseHindi)
            UserDefaults.standard.synchronize()
        }
    }
    
    var lastReadVerseEnglish: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.lastReadVerseEnglish) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.lastReadVerseEnglish)
            UserDefaults.standard.synchronize()
        }
    }
    
    var lastReadChapter: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.lastReadChapter) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.lastReadChapter)
            UserDefaults.standard.synchronize()
        }
    }
    
    var lastReadVerseNum: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.lastReadVerseNum) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.lastReadVerseNum)
            UserDefaults.standard.synchronize()
        }
    }
}
