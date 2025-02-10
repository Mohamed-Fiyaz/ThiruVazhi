//
//  ChapterCard.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI

struct ChapterCard: View {
    let chapter: Chapter
    let showTamilText: Bool
    @ObservedObject var favoriteManager: FavoriteManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(chapter.translation)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    if showTamilText {
                        Text(chapter.name)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Text(chapter.transliteration)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                
                Button(action: {
                    favoriteManager.toggleChapterFavorite(chapterNumber: chapter.number)
                }) {
                    Image(systemName: favoriteManager.favoriteChapters.contains(chapter.number) ? "star.fill" : "star")
                        .foregroundColor(favoriteManager.favoriteChapters.contains(chapter.number) ? .yellow : .gray)
                }
            }
            
            Text("Chapter \(chapter.number)")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 4)
        }
        .padding()
        .background(AppColors.cardBg)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColors.cardStroke, lineWidth: 1)
        )
    }
}
