//
//  ChapterDetail.swift
//  BhagavadGeeta
//
//  Created by Devarsh Bhalara on 31/10/23.
//

import SwiftUI

struct ChapterDetail: View {
    
    @StateObject var viewModel = ChapterDetailViewModel()
    @StateObject var language: Language
    let chapter: String

    
    var body: some View {            
        ScrollView {
                VStack {
                    if let chapter = viewModel.chapter {
                        Text("CHAPTER \(chapter.chapterNumber)")
                            .foregroundColor(Color("primaryColor"))
                            .bold()
                            .font(.title2)
                            .padding(10)
                        
                        Text("\(chapter.translation)" )
                            .fontWeight(.semibold)
                            .font(.title2)
                            .padding(10)
                        if (language.currentLanguage == "en") {
                            Text("\(chapter.summary.en)")
                                .padding(10)
                        } else {
                            Text("\(chapter.summary.hi)")
                                .padding(10)
                        }
                        Text("Total verser \(chapter.versesCount)")
                            .font(.title2)
                            .padding(10)
                        NavigationLink {
                            Verse(verseCount: chapter.versesCount, chapter: "\(chapter.chapterNumber)", slok: nil)
                        } label: {
                            Text("View all Verse")
                                .foregroundStyle(Color.white)
                                .padding(10)
                                .background(Color("primaryColor"))
                                .cornerRadius(10)
                        }

                        
                    }
                    
                }.padding()
                    .onAppear {
                        
                        viewModel.getChapter(ch: chapter)
                    }
                    .navigationBarItems(trailing: Menu {
                        Button {
                            language.currentLanguage = "hi"
                            UserDefaultHelper.shared.language = "hi"
                        } label: {
                            Text("Hindi")
                        }
                        Button {
                            language.currentLanguage = "en"
                            UserDefaultHelper.shared.language = "en"
                        } label: {
                            Text("English")
                        }
                    } label: {
                        Label("Menu Button", systemImage: "textformat")
                            .foregroundStyle(Color.black)
                    })
            
        }
        .navigationBarTitle("Chapter \(chapter)", displayMode: .inline)
        Spacer()
    }
}

#Preview {
    ChapterDetail(language: Language(), chapter: "1")
}
