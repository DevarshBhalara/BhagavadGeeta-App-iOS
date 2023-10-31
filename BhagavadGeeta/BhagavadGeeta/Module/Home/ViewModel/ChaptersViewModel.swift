//
//  ChaptersViewModel.swift
//  BhagavadGeeta
//
//  Created by Devarsh Bhalara on 31/10/23.
//

import Foundation

class ChaptersViewModel: ObservableObject {
    
    @Published var chapters: [Chapter] = []
    @Published var randomSlok: Slok?
    
    func getChapter() {
        APIManager.shared.call(type: .chapters) { [weak self] (result: Result<[Chapter], CustomError>) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let chapters):
                DispatchQueue.main.async {
                    self.chapters = chapters
                }
                
            case .failure(let error):
                print(error.body)
            }
        }
    }
    
    func calculateRandomSlokNumber() -> (Int, Int) {
        let slokCount: [Int] = [47, 72, 43, 42, 29, 47, 30, 28, 34, 42, 55, 20, 35, 27, 20, 24, 28, 78]
        let chapter = Int.random(in: 1...17)
        let maxSlokCount = slokCount[chapter - 1]
        let slok = Int.random(in: 1...maxSlokCount)
        return (chapter, slok)
    }
    
    func getRandomSlok() {
        let slok = calculateRandomSlokNumber()
        APIManager.shared.call(type: .slok("\(slok.0)", "\(slok.1)")) { [weak self] (result: Result<Slok, CustomError>) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let slok):
                DispatchQueue.main.async {
                    UserDefaultHelper.shared.currentDate = AppConstants.getCurrentDate()
                    UserDefaultHelper.shared.randomSlokEnglish = slok.siva.et
                    UserDefaultHelper.shared.randomSlokHindi = slok.tej.ht
                    self.randomSlok = slok
                    print(slok)
                }
                
            case .failure(let error):
                print(error.body)
            }
        }
    }
    
}
