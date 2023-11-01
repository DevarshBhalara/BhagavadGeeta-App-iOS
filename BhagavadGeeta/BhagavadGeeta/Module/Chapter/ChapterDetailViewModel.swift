//
//  ChapterDetailViewModel.swift
//  BhagavadGeeta
//
//  Created by Devarsh Bhalara on 31/10/23.
//

import Foundation
class ChapterDetailViewModel: ObservableObject {
    
    @Published var chapter: Chapter?
    
    func getChapter(ch: String) {
        APIManager.shared.call(type: .chapter(ch)) { [weak self] (result: Result<Chapter, CustomError>) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let chapter):
                DispatchQueue.main.async {
                    self.chapter = chapter
                }
            case .failure(let error):
                print(error.body)
            }
        }
    }
    
}
