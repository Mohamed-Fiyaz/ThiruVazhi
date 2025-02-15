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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3  // Scale only for iPads
        }
        return size
    }

    
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
            if selectedTheme != nil {
                // Fixed Header with Back Button and Toggle
                HStack {
                    Button(action: {
                        selectedTheme = nil
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(AppColors.primaryRed)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text("Show Tamil Text")
                    Toggle("Show Tamil Text", isOn: $viewModel.showTamilText)
                        .labelsHidden()
                        .tint(AppColors.primaryRed)
                        .padding(.trailing)
                }
                .padding(.vertical, 12)
            } else {
                SearchBar(text: $searchText) { query in
                    viewModel.performSearch(query: query)
                }
                .padding()
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if let theme = selectedTheme {
                        Text(theme.title)
                            .font(.system(size: fontSize(22)))
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
                                .font(.system(size: fontSize(17)))
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
                                .font(.system(size: fontSize(17)))
                                .foregroundColor(.secondary)
                                .padding()
                        }
                    } else {
                        Text("Themes")
                            .font(.system(size: fontSize(22)))
                            .fontWeight(.semibold)
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
