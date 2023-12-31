//
//  ContentView.swift
//  BhagavadGeeta
//
//  Created by Devarsh Bhalara on 30/10/23.
//

import SwiftUI

class Language: ObservableObject {
    @Published var currentLanguage: String = UserDefaultHelper.shared.language
}

// MARK: - Main View
struct HomeView: View {
    
    @StateObject var viewModel = ChaptersViewModel()
    let randomSlok = UserDefaultHelper.shared.randomSlokEnglish
    @StateObject private var language = Language()
    @State var lastRead = LastReadModel(lastReadVerseHindi: UserDefaultHelper.shared.lastReadVerseHindi, lastReadVerseEnglish: UserDefaultHelper.shared.lastReadVerseEnglish, lastReadChapter: UserDefaultHelper.shared.lastReadChapter, lastReadVerseNum: UserDefaultHelper.shared.lastReadVerseNum)
    
    var body: some View {
        NavigationStack {
            ScrollView (showsIndicators: false){
                VStack {
                    VerseCard(viewModel: viewModel, language: language, randomSlok: randomSlok)
                    if (UserDefaultHelper.shared.lastReadVerseHindi != "") {
                        LastRead(lastRead: lastRead, language: language)
                    }
                    Text ("Chapters")
                        .bold()
                        .padding(.vertical)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                        .font(.title3)
                    Chapters(viewModel: viewModel, language: language)
                    Spacer()
                }
                .padding()
            }
            .background(Color.cardBG)
            .onAppear {
                if (UserDefaultHelper.shared.currentDate != AppConstants.getCurrentDate()) {
                    viewModel.getRandomSlok()
                }
                viewModel.getChapter()
                print(viewModel.chapters)
            }
            .navigationTitle("Bhagavad Geeta")
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
        .navigationViewStyle(.stack)
        .tint(Color("primaryColor"))
    }
    
}

struct VerseCard: View {
    
    @StateObject var viewModel: ChaptersViewModel
    @StateObject var language: Language
    let randomSlok: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Verse of the Day")
                .font(.title2)
                .bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .textCase(.uppercase)
            if(language.currentLanguage == "en") {
                Text(viewModel.randomSlok?.siva.et ?? randomSlok)
                    .padding(.horizontal)
                    .padding(.bottom)
                
            } else {
                Text(viewModel.randomSlok?.tej.ht ?? UserDefaultHelper.shared.randomSlokHindi)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
        }
        .foregroundColor(Color.white)
        .background(Image("card_bg")
            .resizable()
        )
        .shadow(radius: 10)
        .cornerRadius(10)
    }
    
}

struct LastRead: View {
    
    @State var lastRead: LastReadModel
    @StateObject var language: Language
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Last Read")
                .foregroundColor(Color("primaryColor"))
                .textCase(.uppercase)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title3)
                .bold()
                .padding(.vertical)
            if  language.currentLanguage == "en" {
                Text(lastRead.lastReadVerseEnglish)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                    .lineLimit(4)
            } else {
                Text(lastRead.lastReadVerseHindi)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                    .lineLimit(4)
            }
            Button("Continue Reading") {
                
            }
            .foregroundColor(Color("primaryColor"))
            .textCase(.uppercase)
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("UpdateDataNotification"))) { notification in
                if let dataReceived = notification.userInfo as? [String: Any] {
                    if let value = dataReceived["data"] as? LastReadModel {
                        lastRead = value
                        print("Received data in Screen 1: \(value)")
                    }
                }
            }
        }
    }
}

struct Chapters: View {
    
    @StateObject var viewModel: ChaptersViewModel
    @StateObject var language: Language
    
    var body: some View {
        LazyVStack(spacing: 16, content: {
            ForEach(viewModel.chapters) { chaper in
                
                
                NavigationLink(value: chaper.chapterNumber) {
                    
                    HStack {
                        Text("\(chaper.chapterNumber)")
                            .padding()
                            .background(Color.lightPrimary)
                            .cornerRadius(10)
                            .foregroundColor(Color("primaryColor"))
                            .padding(.trailing, 10)
                        VStack {
                            Text("\(chaper.name) ( \(chaper.translation) )")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .bold()
                                .font(Font.subheadline)
                                .padding(2)
                            Text("\(chaper.meaning.hi) ( \(chaper.meaning.en) )")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(Font.subheadline)
                                .padding(2)
                            Text("\(chaper.versesCount) Verse")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(Font.subheadline)
                                .padding(2)
                        }
                        Spacer()
                        
                    }.padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                .navigationDestination(for: Int.self) { ch in
                    ChapterDetail(language: language, chapter: "\(ch)")
                    Spacer()
                }
            }
        }
        )
        
    }
}


#Preview {
    HomeView()
}
