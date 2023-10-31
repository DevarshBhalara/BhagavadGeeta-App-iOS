//
//  Slok.swift
//  BhagavadGeeta
//
//  Created by Devarsh Bhalara on 31/10/23.
//

import Foundation

// MARK: - Slok
struct Slok: Codable {
    let id: String
    let chapter, verse: Int
    let slok, transliteration: String
    let tej: Tej
    let siva: Siva
    let purohit: Adi
    let chinmay: Chinmay
    let san, adi, gambir: Adi
    let madhav, anand: Anand
    let rams: Rams
    let raman, abhinav, sankar: Abhinav
    let jaya, vallabh, ms, srid: Anand
    let dhan, venkat, puru, neel: Anand

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case chapter, verse, slok, transliteration, tej, siva, purohit, chinmay, san, adi, gambir, madhav, anand, rams, raman, abhinav, sankar, jaya, vallabh, ms, srid, dhan, venkat, puru, neel
    }
}

// MARK: - Abhinav
struct Abhinav: Codable {
    let author, sc, et: String
    let ht: String?
}

// MARK: - Adi
struct Adi: Codable {
    let author, et: String
}

// MARK: - Anand
struct Anand: Codable {
    let author, sc: String
}

// MARK: - Chinmay
struct Chinmay: Codable {
    let author, hc: String
}

// MARK: - Rams
struct Rams: Codable {
    let author, ht, hc: String
}

// MARK: - Siva
struct Siva: Codable {
    let author, et, ec: String
}

// MARK: - Tej
struct Tej: Codable {
    let author, ht: String
}


