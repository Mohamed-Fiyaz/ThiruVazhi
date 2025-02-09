//
//  FavoritesManager.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import Foundation

class FavoriteManager: ObservableObject {
    @Published var favoriteKurals: Set<Int> = []
    @Published var favoriteChapters: Set<Int> = []
    
    private let kuralsKey = "favoriteKurals"
    private let chaptersKey = "favoriteChapters"
    
    init() {
        loadFavorites()
    }
    
    private func loadFavorites() {
        if let kurals = UserDefaults.standard.array(forKey: kuralsKey) as? [Int] {
            favoriteKurals = Set(kurals)
        }
        if let chapters = UserDefaults.standard.array(forKey: chaptersKey) as? [Int] {
            favoriteChapters = Set(chapters)
        }
    }
    
    func toggleKuralFavorite( kuralNumber: Int) {
        if favoriteKurals.contains(kuralNumber) {
            favoriteKurals.remove(kuralNumber)
        } else {
            favoriteKurals.insert(kuralNumber)
        }
        saveFavorites()
    }
    
    func toggleChapterFavorite( chapterNumber: Int) {
        if favoriteChapters.contains(chapterNumber) {
            favoriteChapters.remove(chapterNumber)
        } else {
            favoriteChapters.insert(chapterNumber)
        }
        saveFavorites()
    }
    
    private func saveFavorites() {
        UserDefaults.standard.set(Array(favoriteKurals), forKey: kuralsKey)
        UserDefaults.standard.set(Array(favoriteChapters), forKey: chaptersKey)
    }
}
