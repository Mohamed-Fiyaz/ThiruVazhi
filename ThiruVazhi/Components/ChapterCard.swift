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
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3 
        }
        return size
    }

    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(chapter.translation)
                        .font(.system(size: fontSize(16)))
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .frame(height: 44)
                    
                    if showTamilText {
                        Text(chapter.name)
                            .font(.system(size: fontSize(14)))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: {
                    favoriteManager.toggleChapterFavorite(chapterNumber: chapter.number)
                }) {
                    Image(systemName: favoriteManager.favoriteChapters.contains(chapter.number) ? "star.fill" : "star")
                        .foregroundColor(favoriteManager.favoriteChapters.contains(chapter.number) ? .yellow : .gray)
                        .font(.system(size: fontSize(20)))
                }
            }
            
            Spacer(minLength: 4)
            
            Text("Chapter \(chapter.number)")
                .font(.system(size: fontSize(12)))
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(height: showTamilText ? 140 : 110) 
        .frame(maxWidth: .infinity)
        .background(AppColors.cardBg)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColors.cardStroke, lineWidth: 1)
        )
    }
}
