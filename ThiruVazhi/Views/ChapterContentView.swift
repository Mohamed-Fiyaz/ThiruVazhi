//
//  ChapterContentView.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 20/02/25.
//

import SwiftUI

struct ChapterContentView: View {
    let chapter: Chapter
    @ObservedObject var viewModel: ThirukkuralViewModel
    @ObservedObject var favoriteManager: FavoriteManager
    @Binding var scrollProxy: ScrollViewProxy?
    
    var chapterKurals: [Kural] {
        viewModel.kurals.filter { $0.Number >= chapter.start && $0.Number <= chapter.end }
    }
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                VStack(spacing: 16) {
                    Color.clear.frame(height: 0).id("top")
                    
                    VStack(alignment: .leading, spacing: 8) {
                        if viewModel.showTamilText {
                            Text(chapter.name)
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                        }
                        Text(chapter.translation)
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                        Text("Chapter \(chapter.number)")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        ForEach(chapterKurals) { kural in
                            KuralCard(kural: kural,
                                      showTamilText: viewModel.showTamilText,
                                      favoriteManager: favoriteManager,
                                      viewModel: viewModel,
                                      hideChapterInfo: true)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                }
                .onAppear {
                    scrollProxy = proxy
                }
            }
        }
    }
}
