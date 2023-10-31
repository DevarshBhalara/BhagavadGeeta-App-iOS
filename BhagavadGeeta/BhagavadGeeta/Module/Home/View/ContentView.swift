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
struct ContentView: View {
    
    @StateObject var viewModel = ChaptersViewModel()
    let randomSlok = UserDefaultHelper.shared.randomSlokEnglish
    @StateObject private var language = Language()
    
    var body: some View {
        NavigationView {
            ScrollView (showsIndicators: false){
                VStack {
                    VerseCard(viewModel: viewModel, language: language, randomSlok: randomSlok)
                    LastRead()
                    Text ("Chapters")
                        .bold()
                        .padding(.vertical)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                        .font(.title3)
                    Chapters(viewModel: viewModel)
                    Spacer()
                }
                .padding()
            }.background(Color.cardBG)
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
                    } label: {
                        Text("Hindi")
                    }
                    Button {
                        language.currentLanguage = "en"
                    } label: {
                        Text("English")
                    }
                } label: {
                    Label("Menu Button", systemImage: "textformat")
                        .foregroundStyle(Color.black)
                })
                                       
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
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
        .background(  Image("card_bg")
            .resizable()
        )
        .shadow(radius: 10)
        .cornerRadius(10)
    }
    
}

struct LastRead: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Last Read")
                .foregroundColor(Color("primaryColor"))
                .textCase(.uppercase)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title3)
                .bold()
                .padding(.vertical)
            Text("धृतराष्ट्र उवाच |\nधर्मक्षेत्रे कुरुक्षेत्रे समवेता युयुत्सवः |\nमामकाः पाण्डवाश्चैव किमकुर्वत सञ्जय ||१-१||")
                .foregroundColor(Color.gray)
                .textCase(.uppercase)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            Button("Continue Reading") {
                
            }
            .foregroundColor(Color("primaryColor"))
            .textCase(.uppercase)
        }
    }
}

struct Chapters: View {
    
    @StateObject var viewModel: ChaptersViewModel
    
    var body: some View {
        LazyVStack(spacing: 16, content: {
            ForEach(viewModel.chapters) { chaper in
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
                    .onTapGesture {
                        print(chaper.chapterNumber)
                    }
            }
        })
    }
}


#Preview {
    ContentView()
}
