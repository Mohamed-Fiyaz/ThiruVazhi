//
//  ExploreView.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI

struct ExploreView: View {
    @ObservedObject var viewModel: ThirukkuralViewModel
    @ObservedObject var favoriteManager: FavoriteManager
    @State private var searchText = ""
    @State private var selectedTheme: Theme?
    
    struct Theme: Identifiable {
        let id = UUID()
        let title: String
        let icon: String
        let kuralRanges: [(Int, Int)]
        
        static let themes: [Theme] = [
            Theme(title: "Love & Friendship", icon: "heart", kuralRanges: [
                (71, 78), (79, 80), (81, 82), (83, 84), (107, 115)
            ]),
            Theme(title: "Wisdom & Knowledge", icon: "book", kuralRanges: [
                (35, 36), (39, 43), (65, 66), (67, 68), (69, 70)
            ]),
            Theme(title: "Life Lessons", icon: "leaf", kuralRanges: [
                (5, 6), (45, 48), (49, 50), (51, 52), (91, 93)
            ]),
            Theme(title: "Morality & Ethics", icon: "hand.raised", kuralRanges: [
                (21, 25), (33, 34), (37, 38), (29, 30), (31, 32)
            ]),
            Theme(title: "Discipline & Patience", icon: "clock", kuralRanges: [
                (16, 17), (62, 63), (41, 42), (43, 44), (85, 86)
            ]),
            Theme(title: "Leadership & Service", icon: "person.2", kuralRanges: [
                (38, 39), (55, 56), (57, 58), (59, 60), (73, 74)
            ]),
            Theme(title: "Wealth & Prosperity", icon: "dollarsign.circle", kuralRanges: [
                (101, 103), (20, 20), (31, 32), (33, 34), (75, 76)
            ]),
            Theme(title: "Politics & Generosity", icon: "building.columns", kuralRanges: [
                (55, 63), (23, 24), (25, 26), (27, 28), (44, 45)
            ])
        ]
    }
    
    var filteredKurals: [Kural] {
        if let theme = selectedTheme {
            return viewModel.kurals.filter { kural in
                theme.kuralRanges.contains { range in
                    (range.0...range.1).contains(kural.Number)
                }
            }
        } else if !searchText.isEmpty {
            return viewModel.filteredKurals
        }
        return []
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if selectedTheme == nil {
                SearchBar(text: $searchText) { query in
                    viewModel.performSearch(query: query)
                }
                .padding()
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if let theme = selectedTheme {
                        HStack {
                            Button(action: {
                                selectedTheme = nil
                            }) {
                                HStack {
                                    Image(systemName: "chevron.left")
                                    Text("Back to Themes")
                                }
                                .foregroundColor(AppColors.primaryRed)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Text(theme.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ForEach(filteredKurals) { kural in
                            KuralCard(kural: kural,
                                    showTamilText: viewModel.showTamilText,
                                    favoriteManager: favoriteManager,
                                    viewModel: viewModel,
                                    hideChapterInfo: false)
                                .padding(.horizontal)
                        }
                    } else if !searchText.isEmpty {
                        if !filteredKurals.isEmpty {
                            Text("Search Results")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(filteredKurals) { kural in
                                KuralCard(kural: kural,
                                        showTamilText: viewModel.showTamilText,
                                        favoriteManager: favoriteManager,
                                        viewModel: viewModel,
                                        hideChapterInfo: false)
                                    .padding(.horizontal)
                            }
                        } else {
                            Text("No results found")
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .padding()
                        }
                    } else {
                        Text("Themes")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(Theme.themes) { theme in
                                ThemeButton(title: theme.title, icon: theme.icon) {
                                    selectedTheme = theme
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
