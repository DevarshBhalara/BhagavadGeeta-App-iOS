//
//  Verse.swift
//  BhagavadGeeta
//
//  Created by Devarsh Bhalara on 01/11/23.
//

import SwiftUI
import SlidingTabView

struct Verse: View {
    
    @State private var selectedButton: Int = 0
    @State private var selectedTabIndex = 0
    let verseCount: Int
    let chapter: String
    let slok: String?
    @StateObject var viewModel = VerseViewModel()
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<verseCount) { count in
                            Button("Verse \(count + 1)") {
                                selectedButton = count
                                viewModel.getVerse(ch: chapter, sl: "\(count + 1)")
                            }
                            .padding(8)
                            .foregroundColor(selectedButton == count ? Color("primaryColor") : Color.black)
                        }
                    }
                }
                Rectangle()
                    .frame(height: 1)
                    .padding(.vertical,8)
                if let verse = viewModel.verse {
                    Text("|| \(chapter).\(verse.verse) ||")
                        .foregroundStyle(Color("primaryColor"))
                        .font(.title2)
                        .bold()
                        .padding()
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
                if slok == nil {
                    viewModel.getVerse(ch: chapter, sl: "1")
                }
            }
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