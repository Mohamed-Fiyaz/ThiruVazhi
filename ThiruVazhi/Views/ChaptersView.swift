//
//  ChaptersView.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI

struct ChaptersView: View {
    @ObservedObject var viewModel: ThirukkuralViewModel
    @ObservedObject var favoriteManager: FavoriteManager
    @State private var selectedBook = "Virtue"
    @State private var searchText = ""
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    private func fontSize(_ size: CGFloat) -> CGFloat {
        sizeClass == .regular ? size * 1.3 : size
    }
    
    var filteredChapters: [Chapter] {
        guard let details = viewModel.details else { return [] }
        let chapters = details.section.detail
            .filter { $0.translation == selectedBook }
            .flatMap { book in
                book.chapterGroup.detail.flatMap { group in
                    group.chapters.detail
                }
            }
        
        if searchText.isEmpty {
            return chapters
        }
        
        return chapters.filter { chapter in
            chapter.translation.localizedCaseInsensitiveContains(searchText) ||
            chapter.transliteration.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Select a Book")
                    .font(.system(size: fontSize(22)))
                    .fontWeight(.semibold)
                    .padding(.top, 20)
                
                HStack(spacing: 12) {
                    ForEach(["Virtue", "Wealth", "Love"], id: \.self) { book in
                        Button(action: {
                            selectedBook = book
                        }) {
                            Text(book)
                                .font(.system(size: fontSize(16)))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(selectedBook == book ? AppColors.primaryRed : Color.clear)
                                .foregroundColor(selectedBook == book ? .white : .primary)
                                .cornerRadius(20)
                        }
                    }
                }
                
                SearchBar(text: $searchText) { _ in }
                    .padding(.horizontal)
                
                ScrollView {
                    ScrollViewReader { proxy in
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(filteredChapters) { chapter in
                                NavigationLink(destination: ChapterDetailView(chapter: chapter, viewModel: viewModel, favoriteManager: favoriteManager)) {
                                    ChapterCard(chapter: chapter, showTamilText: viewModel.showTamilText, favoriteManager: favoriteManager)
                                }
                                .id(chapter.number)
                            }.padding(.top,2)
                        }
                        .padding()
                        .onChange(of: selectedBook) { _ in
                            if let firstChapter = filteredChapters.first {
                                proxy.scrollTo(firstChapter.number, anchor: .top)
                            }
                        }
                    }
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
