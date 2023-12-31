//
//  AppUrls.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 05/07/23.
//

import Foundation

class AppConstants {
    static let baseApi = "https://bhagavadgitaapi.in/"
    static let api = "api/"
    static let apiVersion = "v1/"
    static let HC = "Hindi Commentary"
    static let EC = "English Commentary"
    static let SC = "Sanskrit Commentary"
    static let HT = "Hindi Translation"
    static let ET = "English Translation"
    
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
}
