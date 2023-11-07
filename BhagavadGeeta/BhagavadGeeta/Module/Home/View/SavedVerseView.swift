//
//  SavedVerse.swift
//  BhagavadGeeta
//
//  Created by Devarsh Bhalara on 06/11/23.
//

import SwiftUI

struct SavedVerseView: View {
    
    @StateObject var language: Language
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ListVerseView(language: language)
            }
            .background(Color.cardBG)
            .navigationTitle("Your Saved Verse")
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
    }
}

#Preview {
    SavedVerseView(language: Language())
}


struct ListVerseView: View {
    
    @FetchRequest(sortDescriptors: []) var savedVerse: FetchedResults<SavedVerse>
    @StateObject var language: Language
    
    var body: some View {
        LazyVStack {
            ForEach(savedVerse) { verse in
                if let ch = verse.ch, let sl = verse.sl, let enVerse = verse.verseEnglish, let verse = verse.verse {
                    
                    NavigationLink(value: [ch, sl]) {
                        VStack (alignment: .leading) {
                            Text("\(ch).\(sl)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .bold()
                                .font(.title3)
                            if language.currentLanguage == "en" {
                                Text(enVerse)
                            } else {
                                Text(verse)
                            }
                        }
                        .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .navigationDestination(for: [String].self) { items in
                        Verse(verseCount: 0, chapter: items[0], slok: items[1])
                        Spacer()
                    }
                }
                
            }
            
        }
        .padding(8)
    }
}
