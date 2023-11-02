//
//  VerseViewModel.swift
//  BhagavadGeeta
//
//  Created by Devarsh Bhalara on 01/11/23.
//

import Foundation

class VerseViewModel: ObservableObject {
    
    @Published var verse: Slok?
    @Published var authors: [Authors] = []
    
    func getVerse(ch: String, sl: String) {
        verse = nil
        APIManager.shared.call(type: .slok(ch, sl)) { [weak self] (result: Result<Slok, CustomError>) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let verse):
                self.verse = verse
                self.authors = getAuthors(slok: verse)
            case .failure(let error):
                print(error.body)
            }
        }
    }
    
    func getAuthors(slok: Slok) -> [Authors] {
        var authors: [Authors] = []

        authors.append(
            Authors(
                authorName: slok.tej.author,
                hindiTranslation: slok.tej.ht,
                totalCommentaryTranslation: 1,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.HT, content: slok.tej.ht)]
            )
        )

        authors.append(
            Authors(
                authorName: slok.siva.author,
                englishTranslation: slok.siva.et,
                englishCommentary: slok.siva.ec,
                isExpanded: false,
                translation: [
                    TranslationOrCommentary(title: AppConstants.ET, content: slok.siva.et),
                    TranslationOrCommentary(title: AppConstants.EC, content: slok.siva.ec)
                ]
            )
        )

        authors.append(
            Authors(
                authorName: slok.purohit.author,
                englishTranslation: slok.purohit.et,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.ET, content: slok.purohit.et)]
            )
        )

        authors.append(
            Authors(
                authorName: slok.chinmay.author,
                hindiCommentary: slok.chinmay.hc,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.HC, content: slok.chinmay.hc)]
            )
        )
        
        authors.append(
            Authors(
                authorName: slok.san.author,
                englishTranslation: slok.san.et,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.ET, content: slok.san.et)]
            )
        )

        authors.append(
            Authors(
                authorName: slok.adi.author,
                englishTranslation: slok.adi.et,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.ET, content: slok.adi.et)]
            )
        )

        authors.append(
            Authors(
                authorName: slok.gambir.author,
                englishTranslation: slok.gambir.et,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.ET, content: slok.gambir.et)]
            )
        )

        authors.append(
            Authors(
                authorName: slok.madhav.author,
                sanskritCommentary: slok.madhav.sc,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.SC, content: slok.madhav.sc)]
            )
        )
        
        authors.append(
            Authors(
                authorName: slok.anand.author,
                sanskritCommentary: slok.anand.sc,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.SC, content: slok.anand.sc)]
            )
        )

        authors.append(
            Authors(
                authorName: slok.rams.author,
                hindiTranslation: slok.rams.ht,
                hindiCommentary: slok.rams.hc,
                isExpanded: false,
                translation: [
                    TranslationOrCommentary(title: AppConstants.HT, content: slok.rams.ht),
                    TranslationOrCommentary(title: AppConstants.HC, content: slok.rams.hc)
                ]
            )
        )

        authors.append(
            Authors(
                authorName: slok.raman.author,
                englishTranslation: slok.raman.et, 
                sanskritCommentary: slok.raman.sc,
                isExpanded: false,
                translation: [
                    TranslationOrCommentary(title: AppConstants.SC, content: slok.raman.sc),
                    TranslationOrCommentary(title: AppConstants.ET, content: slok.raman.et)
                ]
            )
        )

        authors.append(
            Authors(
                authorName: slok.abhinav.author,
                englishTranslation: slok.abhinav.et, 
                sanskritCommentary: slok.abhinav.sc,
                isExpanded: false,
                translation: [
                    TranslationOrCommentary(title: AppConstants.SC, content: slok.abhinav.sc),
                    TranslationOrCommentary(title: AppConstants.ET, content: slok.abhinav.et)
                ]
            )
        )
        
        authors.append(
            Authors(
                authorName: slok.sankar.author,
                hindiTranslation: slok.sankar.ht, 
                englishTranslation: slok.sankar.et, 
                sanskritCommentary: slok.sankar.sc,
                isExpanded: false,
                translation: [
                    TranslationOrCommentary(title: AppConstants.SC, content: slok.sankar.sc),
                    TranslationOrCommentary(title: AppConstants.ET, content: slok.sankar.et),
                    TranslationOrCommentary(title: AppConstants.HT, content: slok.sankar.ht)
                ]
            )
        )

        authors.append(
            Authors(
                authorName: slok.jaya.author,
                sanskritCommentary: slok.jaya.sc,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.SC, content: slok.jaya.sc)]
            )
        )

        authors.append(
            Authors(
                authorName: slok.vallabh.author,
                sanskritCommentary: slok.vallabh.sc,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.SC, content: slok.vallabh.sc)]
            )
        )

        authors.append(
            Authors(
                authorName: slok.ms.author,
                sanskritCommentary: slok.ms.sc,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.SC, content: slok.ms.sc)]
            )
        )

        authors.append(
            Authors(
                authorName: slok.srid.author,
                sanskritCommentary: slok.srid.sc,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.SC, content: slok.srid.sc)]
            )
        )

        authors.append(
            Authors(
                authorName: slok.dhan.author,
                sanskritCommentary: slok.dhan.sc,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.SC, content: slok.dhan.sc)]
            )
        )

        authors.append(
            Authors(
                authorName: slok.venkat.author,
                sanskritCommentary: slok.venkat.sc,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.SC, content: slok.venkat.sc)]
            )
        )

        authors.append(
            Authors(
                authorName: slok.puru.author,
                sanskritCommentary: slok.puru.sc,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.SC, content: slok.puru.sc)]
            )
        )

        authors.append(
            Authors(
                authorName: slok.neel.author,
                sanskritCommentary: slok.neel.sc,
                isExpanded: false,
                translation: [TranslationOrCommentary(title: AppConstants.SC, content: slok.neel.sc)]
            )
        )





        // Continue adding authors as per your original Kotlin code...

        return authors
    }

}
