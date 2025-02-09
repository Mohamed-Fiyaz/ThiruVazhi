//
//  ChapterDetailView.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import Foundation
import SwiftUI

struct ChapterDetailView: View {
    let chapter: Chapter
    @ObservedObject var viewModel: ThirukkuralViewModel
    @ObservedObject var favoriteManager: FavoriteManager
    
    var chapterKurals: [Kural] {
        viewModel.kurals.filter { $0.Number >= chapter.start && $0.Number <= chapter.end }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(chapter.translation)
                    .font(.title)
                    .padding(.top)
                
                ForEach(chapterKurals) { kural in
                    KuralCard(kural: kural, showTamilText: viewModel.showTamilText, favoriteManager: favoriteManager)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
