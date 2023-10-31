//
//  Chapter.swift
//  BhagavadGeeta
//
//  Created by Devarsh Bhalara on 31/10/23.
//

import Foundation

struct Chapter: Codable, Identifiable {
    var id = UUID()
    
    let chapterNumber, versesCount: Int
    let name, translation, transliteration: String
    let meaning, summary: Meaning

    enum CodingKeys: String, CodingKey {
        case chapterNumber = "chapter_number"
        case versesCount = "verses_count"
        case name, translation, transliteration, meaning, summary
    }
}

// MARK: - Meaning
struct Meaning: Codable {
    let en, hi: String
}

