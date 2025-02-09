//
//  ExploreView.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import Foundation
import SwiftUI

struct ExploreView: View {
    @ObservedObject var viewModel: ThirukkuralViewModel
    @ObservedObject var favoriteManager: FavoriteManager
    @State private var searchText = ""
    
    let themes = [
        ("Love & Friendship", "heart"),
        ("Wisdom & Knowledge", "book"),
        ("Life Lessons", "leaf"),
        ("Morality & Ethics", "hand.raised"),
        ("Discipline & Patience", "clock"),
        ("Leadership & Service", "person.2"),
        ("Wealth & Prosperity", "dollarsign.circle"),
        ("Politics & Generosity", "building.columns")
    ]
    
    var filteredKurals: [Kural] {
        if searchText.isEmpty {
            return []
        }
        return viewModel.kurals.filter { kural in
            kural.Translation.localizedCaseInsensitiveContains(searchText) ||
            kural.explanation.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(text: $searchText)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if !searchText.isEmpty {
                        Text("Search Results")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(filteredKurals) { kural in
                            KuralCard(kural: kural, showTamilText: viewModel.showTamilText, favoriteManager: favoriteManager)
                        }
                    } else {
                        Text("Themes")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(themes, id: \.0) { theme in
                                ThemeButton(title: theme.0, icon: theme.1) {
                                    // Handle theme selection
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}
