//
//  FavoritesView.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: ThirukkuralViewModel
    @ObservedObject var favoriteManager: FavoriteManager
    
    var favoriteKurals: [Kural] {
        viewModel.kurals.filter { favoriteManager.favoriteKurals.contains($0.Number) }
    }
    
    var favoriteChapters: [Chapter] {
        guard let details = viewModel.details else { return [] }
        return details.section.detail.flatMap { book in
            book.chapterGroup.detail.flatMap { group in
                group.chapters.detail.filter { favoriteManager.favoriteChapters.contains($0.number) }
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if !favoriteKurals.isEmpty {
                    Text("Favorite Thirukkurals")
                        .font(.title2)
                        .padding(.horizontal)
                    
                    ForEach(Array(favoriteKurals.prefix(viewModel.expandedFavoriteKurals ? favoriteKurals.count : 5))) { kural in
                        KuralCard(kural: kural,
                                showTamilText: viewModel.showTamilText,
                                favoriteManager: favoriteManager,
                                viewModel: viewModel,
                                hideChapterInfo: false)
                            .padding(.horizontal)
                    }
                    
                    if favoriteKurals.count > 5 {
                        Button(action: {
                            viewModel.expandedFavoriteKurals.toggle()
                        }) {
                            Text(viewModel.expandedFavoriteKurals ? "Show Less" : "Show More")
                                .foregroundColor(AppColors.primaryRed)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                
                if !favoriteChapters.isEmpty {
                    Text("Favorite Chapters")
                        .font(.title2)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(Array(favoriteChapters.prefix(viewModel.expandedFavoriteChapters ? favoriteChapters.count : 6))) { chapter in
                            ChapterCard(chapter: chapter,
                                      showTamilText: viewModel.showTamilText,
                                      favoriteManager: favoriteManager)
                        }
                    }
                    .padding(.horizontal)
                    
                    if favoriteChapters.count > 6 {
                        Button(action: {
                            viewModel.expandedFavoriteChapters.toggle()
                        }) {
                            Text(viewModel.expandedFavoriteChapters ? "Show Less" : "Show More")
                                .foregroundColor(AppColors.primaryRed)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                
                if favoriteKurals.isEmpty && favoriteChapters.isEmpty {
                    Text("No favorites yet")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                }
            }
            .padding(.vertical)
        }
    }
}
