//
//  ChapterCard.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import Foundation
import SwiftUI

struct ChapterCard: View {
    let chapter: Chapter
    let showTamilText: Bool
    @ObservedObject var favoriteManager: FavoriteManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(chapter.translation)
                    .font(.headline)
                Spacer()
                Button(action: {
                    favoriteManager.toggleChapterFavorite(chapterNumber: chapter.number)
                }) {
                    Image(systemName: favoriteManager.favoriteChapters.contains(chapter.number) ? "star.fill" : "star")
                }
            }
            
            if showTamilText {
                Text(chapter.name)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
