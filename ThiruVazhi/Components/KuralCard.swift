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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Kural")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
                Button(action: {
                    favoriteManager.toggleKuralFavorite(kuralNumber: kural.Number)
                }) {
                    ZStack {
                        Image(systemName: "star")
                            .font(.system(size: 25))
                            .foregroundColor(AppColors.cardStroke)
                        if favoriteManager.favoriteKurals.contains(kural.Number) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
            
            if showTamilText {
                Text(kural.Line1)
                    .font(.headline)
                Text(kural.Line2)
                    .font(.headline)
            }
            
            Text("Porul")
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
