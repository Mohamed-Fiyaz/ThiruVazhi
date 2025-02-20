//
//  KuralCard.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI

struct KuralCard: View {
    let kural: Kural
    let showTamilText: Bool
    @ObservedObject var favoriteManager: FavoriteManager
    @ObservedObject var viewModel: ThirukkuralViewModel
    let hideChapterInfo: Bool
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3  
        }
        return size
    }

    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    if !hideChapterInfo {
                        if let (chapter, book) = viewModel.getChapterAndBookForKural(kural.Number) {
                            Text("Book: \(book)")
                                .font(.system(size: fontSize(15)))
                                .foregroundColor(.secondary)
                            Text("Chapter: \(chapter)")
                                .font(.system(size: fontSize(15)))
                                .foregroundColor(.secondary)
                        }
                    }
                    Text("Kural \(kural.Number)")
                        .font(.system(size: fontSize(15)))
                        .foregroundColor(.secondary)
                }
                Spacer()
                Button(action: {
                    favoriteManager.toggleKuralFavorite(kuralNumber: kural.Number)
                }) {
                    Image(systemName: favoriteManager.favoriteKurals.contains(kural.Number) ? "star.fill" : "star")
                        .foregroundColor(favoriteManager.favoriteKurals.contains(kural.Number) ? .yellow : .gray)
                        .font(.system(size: fontSize(16)))
                }
            }
            
            if showTamilText {
                Text(kural.Line1)
                    .font(.system(size: fontSize(20)))
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                Text(kural.Line2)
                    .font(.system(size: fontSize(20)))
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                Text("Translation")
                    .font(.system(size: fontSize(15)))
                    .foregroundColor(.secondary)
            }

            Text(kural.Translation)
                .font(.system(size: fontSize(18)))
                .fontWeight(.medium)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .lineSpacing(6)
            
            Text("Meaning")
                .font(.system(size: fontSize(15)))
                .foregroundColor(.secondary)
            Text(kural.explanation)
                .font(.system(size: fontSize(18)))
                .lineLimit(3)
                .minimumScaleFactor(0.8)
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
