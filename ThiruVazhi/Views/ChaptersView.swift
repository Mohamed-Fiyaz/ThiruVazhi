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
    @State private var selectedBook = "All"
    @State private var searchText = ""
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @FocusState private var isSearchFocused: Bool
    @Binding var scrollProxy: ScrollViewProxy?
    @State private var isSearching = false
    @State private var selectedChapter: Chapter?
    @State private var scrollID = UUID()
    
    private func fontSize(_ size: CGFloat) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad && horizontalSizeClass == .regular {
            return size * 1.3
        }
        return size
    }
    
    var filteredChapters: [Chapter] {
        // Existing filtered chapters logic remains the same
        guard let details = viewModel.details else { return [] }
        let allChapters = details.section.detail.flatMap { book in
            book.chapterGroup.detail.flatMap { group in
                group.chapters.detail
            }
        }
        
        let filteredByBook = selectedBook == "All"
            ? allChapters
            : details.section.detail
                .filter { $0.translation == selectedBook }
                .flatMap { book in
                    book.chapterGroup.detail.flatMap { group in
                        group.chapters.detail
                    }
                }
        
        if searchText.isEmpty {
            return filteredByBook
        }
        
        let cleanedSearch = searchText.lowercased().replacingOccurrences(of: "chapter", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let searchNumber = Int(cleanedSearch) {
            return filteredByBook.filter { chapter in
                chapter.number == searchNumber
            }
        }
        
        return filteredByBook.filter { chapter in
            chapter.translation.localizedCaseInsensitiveContains(searchText) ||
            chapter.name.localizedCaseInsensitiveContains(searchText) ||
            "chapter \(chapter.number)".localizedCaseInsensitiveContains(searchText)
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
                    ChapterDetailView(
                        chapter: chapter,
                        viewModel: viewModel,
                        favoriteManager: favoriteManager,
                        scrollProxy: $scrollProxy
                    )
                    .id("chapter-\(chapter.number)-\(scrollID.uuidString)")
                }
            } else {
                VStack(spacing: 16) {
                    Text("Select a Book")
                        .font(.system(size: fontSize(22)))
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    HStack(spacing: 12) {
                        ForEach(["All", "Virtue", "Wealth", "Love"], id: \.self) { book in
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

                    SearchBar(text: $searchText, onSearch: { query in

                        searchText = query
                    }, isFocused: $isSearchFocused)
                        .padding(.horizontal)
                    if !searchText.isEmpty && filteredChapters.isEmpty {
                        VStack {
                            Text("No results found")
                                .font(.system(size: fontSize(17)))
                                .foregroundColor(.secondary)
                                .padding()
                                Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                    ScrollView {
                        ScrollViewReader { proxy in
                            VStack {
                                Color.clear.frame(height: 0).id("top")
                                
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                    ForEach(filteredChapters) { chapter in
                                        Button(action: {
                                            scrollID = UUID()
                                            selectedChapter = chapter
                                        }) {
                                            ChapterCard(chapter: chapter,
                                                        showTamilText: viewModel.showTamilText,
                                                        favoriteManager: favoriteManager)
                                        }
                                        .id(chapter.number)
                                    }.padding(.top, 2)
                                }
                                .padding()
                                .onChange(of: selectedBook) { _ in
                                    if let firstChapter = filteredChapters.first {
                                        proxy.scrollTo(firstChapter.number, anchor: .top)
                                    }
                                }
                            }
                            .onAppear {
                                scrollProxy = proxy
                            }
                        }
                        }
                    }
                }
            }
        }
        .background(AppColors.primaryBG)
        .onTapGesture {
            isSearchFocused = false
            hideKeyboard()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
