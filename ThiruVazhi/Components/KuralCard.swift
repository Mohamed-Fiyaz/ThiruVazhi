//
//  KuralCard.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import Foundation
import SwiftUI

struct KuralCard: View {
    let kural: Kural
    let showTamilText: Bool
    @ObservedObject var favoriteManager: FavoriteManager
    @ObservedObject var viewModel: ThirukkuralViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    if let (chapter, book) = viewModel.getChapterAndBookForKural(kural.Number) {
                        Text("Book: \(book)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Chapter: \(chapter)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Text("Kural \(kural.Number)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Button(action: {
                    favoriteManager.toggleKuralFavorite(kuralNumber: kural.Number)
                }) {
                    Image(systemName: favoriteManager.favoriteKurals.contains(kural.Number) ? "star.fill" : "star")
                            .foregroundColor(favoriteManager.favoriteKurals.contains(kural.Number) ? .yellow : .gray)
                    }
                }
            
            if showTamilText {
                Text(kural.Line1)
                    .font(.headline)
                Text(kural.Line2)
                    .font(.headline)
            }
            
            Text("Meaning")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(kural.Translation)
                .font(.body)
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
