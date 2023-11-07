//
//  HomeTabBar.swift
//  BhagavadGeeta
//
//  Created by Devarsh Bhalara on 06/11/23.
//

import SwiftUI

struct HomeTabBar: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                        .foregroundStyle(Color.black)
                    
                }
            SavedVerseView(language: Language())
                .tabItem {
                    Label("Saved", systemImage: "bookmark.fill")
                        .foregroundStyle(Color.black)
                    
                }
        }
        .accentColor(Color("primaryColor"))
    }
}

#Preview {
    HomeTabBar()
}
