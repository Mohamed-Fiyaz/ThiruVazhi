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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var refreshing = false
    @State private var selectedTab = 0
    @Binding var scrollProxy: ScrollViewProxy?
    @State private var scrollID = UUID()
    @State private var selectedChapter: Chapter?
    
    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3
        }
        return size
    }
    
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
        VStack(spacing: 0) {
            if selectedChapter != nil {
                HStack {
                    Button(action: {
                        scrollID = UUID()
                        selectedChapter = nil
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: fontSize(17)))
                            Text("Back")
                                .font(.system(size: fontSize(17)))
                        }
                        .foregroundColor(AppColors.primaryRed)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text("Show Tamil Text")
                        .font(.system(size: fontSize(17)))
                    Toggle("Show Tamil Text", isOn: $viewModel.showTamilText)
                        .labelsHidden()
                        .tint(AppColors.primaryRed)
                        .padding(.trailing)
                        .font(.system(size: fontSize(17)))
                }
                .padding(.vertical, 12)
                
                if let chapter = selectedChapter {
                    ChapterContentView(
                        chapter: chapter,
                        viewModel: viewModel,
                        favoriteManager: favoriteManager,
                        scrollProxy: $scrollProxy
                    )
                    .id("chapter-\(chapter.number)-\(scrollID.uuidString)")
                }
            } else {
                ScrollView {
                    ScrollViewReader { proxy in
                        VStack(alignment: .leading, spacing: 20) {
                            Color.clear
                                .frame(height: 0)
                                .id("top")
                            
                            if !favoriteKurals.isEmpty {
                                Text("Favorite Thirukkurals")
                                    .font(.system(size: fontSize(22)))
                                    .fontWeight(.semibold)
                                    .padding(.horizontal)
                                
                                ForEach(Array(favoriteKurals.prefix(viewModel.expandedFavoriteKurals ? favoriteKurals.count : 3))) { kural in
                                    KuralCard(kural: kural,
                                            showTamilText: viewModel.showTamilText,
                                            favoriteManager: favoriteManager,
                                            viewModel: viewModel,
                                            hideChapterInfo: false)
                                        .padding(.horizontal)
                                }
                                
                                if favoriteKurals.count > 3 {
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
                                    .font(.system(size: fontSize(22)))
                                    .fontWeight(.semibold)
                                    .padding(.horizontal)
                                
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                    ForEach(Array(favoriteChapters.prefix(viewModel.expandedFavoriteChapters ? favoriteChapters.count : 6))) { chapter in
                                        Button(action: {
                                            scrollID = UUID()
                                            selectedChapter = chapter
                                        }) {
                                            ChapterCard(chapter: chapter, showTamilText: viewModel.showTamilText, favoriteManager: favoriteManager)
                                        }
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
                                    .font(.system(size: fontSize(17)))
                                    .foregroundColor(.secondary)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding()
                            }
                        }
                        .padding(.vertical)
                        .onAppear {
                            scrollProxy = proxy
                        }
                    }
                }
            }
        }
        .background(AppColors.primaryBG)
    }
}
