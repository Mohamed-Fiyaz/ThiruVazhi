//
//  FavoritesView.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import Foundation
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
            book.chapterGroup.detail.filter { favoriteManager.favoriteChapters.contains($0.number) }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if !favoriteKurals.isEmpty {
                    Text("Favorite Thirukkurals")
                        .font(.title2)
                        .padding(.horizontal)
                    
                    ForEach(favoriteKurals) { kural in
                        KuralCard(kural: kural, showTamilText: viewModel.showTamilText, favoriteManager: favoriteManager)
                    }
                }
                
                if !favoriteChapters.isEmpty {
                    Text("Favorite Chapters")
                        .font(.title2)
                        .padding(.horizontal)
                    
                    ForEach(favoriteChapters) { chapter in
                        ChapterCard(chapter: chapter, showTamilText: viewModel.showTamilText, favoriteManager: favoriteManager)
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
            .padding()
        }
    }
}
