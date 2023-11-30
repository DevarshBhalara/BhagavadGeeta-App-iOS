//
//  Verse.swift
//  BhagavadGeeta
//
//  Created by Devarsh Bhalara on 01/11/23.
//

import SwiftUI

struct Verse: View {
    
    @State private var selectedButton: Int = 0
    @State private var selectedTabIndex = 0
    let verseCount: Int
    let chapter: String
    let slok: String?
    @State var bookMarkImage: String = ""
    @StateObject var viewModel = VerseViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var savedVerse: FetchedResults<SavedVerse>
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                
                if verseCount > 0 {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(Array(0..<verseCount), id: \.self) { count in
                                Button("Verse \(count + 1)") {
                                    selectedButton = count
                                    viewModel.getVerse(ch: chapter, sl: "\(count + 1)")
                                    changeIcon(ch: chapter, sl: "\(count + 1)")
                                    
                                }
                                .padding(8)
                                .foregroundColor(selectedButton == count ? Color("primaryColor") : Color.black)
                            }
                        }
                    }
                    Rectangle()
                        .frame(height: 1)
                        .padding(.vertical,8)
                }
                if let verse = viewModel.verse {
                    Text("|| \(chapter).\(verse.verse) ||")
                        .foregroundStyle(Color("primaryColor"))
                        .font(.title2)
                        .bold()
                        .padding()
                        .onAppear {
                            setLastRead(lastRead: LastReadModel(lastReadVerseHindi: verse.tej.ht, lastReadVerseEnglish: verse.siva.et, lastReadChapter: chapter, lastReadVerseNum: "\(verse.verse)"))
                           
                        }
                    Text(verse.slok)
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .padding(.horizontal)
                    Text("TRANSLITERATION")
                        .padding()
                        .foregroundStyle(Color("primaryColor"))
                        .font(.title2)
                        .bold()
                    Text(verse.transliteration)
                        .multilineTextAlignment(.center)
                        .font(.title3)
                    Text("Translation by Different Authors")
                        .padding()
                        .foregroundStyle(Color("primaryColor"))
                        .font(.title2)
                        .bold()
                    DisclosureGroupView(authors: $viewModel.authors)
                    
                } else {
                    ProgressView()
                }
                
            }.onAppear {
                viewModel.viewContext = viewContext
                if slok == nil {
                    viewModel.getVerse(ch: chapter, sl: "1")
                    changeIcon(ch: chapter, sl: "1")
                } else {
                    viewModel.getVerse(ch: chapter, sl: slok!)
                }
                
            }
            .navigationBarItems(trailing:  Button("", systemImage: bookMarkImage, action: {
                if let slok = viewModel.verse?.tej.ht, let englishVerse = viewModel.verse?.siva.et, let sl = viewModel.verse?.verse{
                    
                    let isSaved = savedVerse.filter { item in
                        return item.ch == chapter && item.sl == "\(sl)"
                    }
                    
                    if isSaved.isEmpty {
                        viewModel.create(ch: chapter, sl: "\(sl)", verse: slok, verseEnglish: englishVerse) {
                            changeIcon(ch: chapter, sl: "\(sl)")
                        }
                    } else {
                        viewModel.removeFromsave(verse: isSaved.first!) { ch, sl in
                            changeIcon(ch: ch, sl: sl)
                        }
                    }
                }
            }))
        }
        .navigationBarTitle("", displayMode: .inline)
    }
    
    func setLastRead(lastRead: LastReadModel) {
        UserDefaultHelper.shared.lastReadChapter = lastRead.lastReadChapter
        UserDefaultHelper.shared.lastReadVerseNum = lastRead.lastReadVerseNum
        UserDefaultHelper.shared.lastReadVerseHindi = lastRead.lastReadVerseHindi
        UserDefaultHelper.shared.lastReadVerseEnglish = lastRead.lastReadVerseEnglish
        NotificationCenter.default.post(name: NSNotification.Name("UpdateDataNotification"), object: nil, userInfo: ["data": lastRead])
    }
    
    func changeIcon(ch: String, sl: String) {
        let isSaved = savedVerse.filter { item in
            return item.ch == ch && item.sl == sl
        }.isEmpty
        
        if !isSaved {
            bookMarkImage = "bookmark.fill"
        } else {
            bookMarkImage = "bookmark"
        }
    }
}

struct DisclosureGroupView: View {
    
    @Binding var authors: [Authors]
    
    var body: some View {
        ForEach(authors.indices, id: \.self) { index in
            DisclosureGroup(
                isExpanded: $authors[index].isExpanded,
                content: {
                    ForEach(authors[index].translation, id: \.self) { subItem in
                        VStack {
                            Text(subItem.title)
                                .padding(8)
                                .bold()
                            Text(subItem.content ?? "N/A")
                                .padding(8)
                        }
                    }
                },
                label: {
                    VStack(alignment: .leading) {
                        Text(authors[index].authorName)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .foregroundStyle(Color.black)
                            .bold()
                            .textCase(.uppercase)
                            .multilineTextAlignment(.leading)
                        if (!authors[index].isExpanded) {
                            Rectangle()
                                .frame(height: 1)
                                .padding(.vertical, 4)
                                .foregroundStyle(Color.black)
                        }
                    }
                }
            )
        }
    }
}

#Preview {
    Verse(verseCount: 20, chapter: "1", slok: nil)
}
