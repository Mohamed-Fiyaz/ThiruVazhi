//
//  ThirukkuralViewModel.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import SwiftUI
import Combine

class ThirukkuralViewModel: ObservableObject {
    @Published var kurals: [Kural] = []
    @Published var details: DetailData?
    @Published var kuralOfTheDay: Kural?
    @Published var randomKural: Kural?
    @Published var filteredKurals: [Kural] = []
    @Published var famousKurals: [Kural] = []
    @Published var isSearching = false
    
    @Published var showTamilText: Bool {
        didSet {
            UserDefaults.standard.set(showTamilText, forKey: "showTamilText")
        }
    }
    
    // Change these to regular properties since we want to reset them
    @Published var expandedFavoriteKurals = false
    @Published var expandedFavoriteChapters = false

    private var searchWorkItem: DispatchWorkItem?
    private var searchIndex: [(kural: Kural, searchText: String)] = []
    private let famousKuralNumbers = [1, 12, 45, 396, 400, 421, 596, 619, 664, 666]

    func getChapterAndBookForKural(_ kuralNumber: Int) -> (chapterName: String, bookName: String)? {
        guard let details = details else { return nil }
        
        for book in details.section.detail {
            for chapterGroup in book.chapterGroup.detail {
                for chapter in chapterGroup.chapters.detail {
                    if kuralNumber >= chapter.start && kuralNumber <= chapter.end {
                        return (chapter.translation, book.translation)
                    }
                }
            }
        }
        return nil
    }
    
    func resetFavoritesExpansion() {
        expandedFavoriteKurals = false
        expandedFavoriteChapters = false
    }
    
    init() {

        self.showTamilText = UserDefaults.standard.bool(forKey: "showTamilText")
        
        loadData()
        setKuralOfTheDay()
        generateRandomKural()
        setupSearchIndex()
        setupFamousKurals()
    }
    
    private func setupSearchIndex() {
        searchIndex = kurals.map { kural in
            let searchText = "\(kural.Translation.lowercased()) \(kural.explanation.lowercased())"
            return (kural: kural, searchText: searchText)
        }
    }
    
    private func setupFamousKurals() {
        famousKurals = kurals.filter { famousKuralNumbers.contains($0.Number) }
    }
    
    func performSearch(query: String) {
        searchWorkItem?.cancel()
        
        DispatchQueue.main.async {
            self.isSearching = true
        }

        if query.isEmpty {
            DispatchQueue.main.async {
                self.filteredKurals = []
                self.isSearching = false
            }
            return
        }
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            Thread.sleep(forTimeInterval: 0.3)
            
            let lowercasedQuery = query.lowercased()
            let results = self.searchIndex
                .filter { $0.searchText.contains(lowercasedQuery) }
                .map { $0.kural }
                .prefix(50)
            
            DispatchQueue.main.async {
                self.filteredKurals = Array(results)
                self.isSearching = false
            }
        }
        
        searchWorkItem = workItem
        DispatchQueue.global(qos: .userInitiated).async(execute: workItem)
    }

    private func loadData() {
        if let kuralURL = Bundle.main.url(forResource: "thirukkural", withExtension: "json"),
           let detailURL = Bundle.main.url(forResource: "detail", withExtension: "json") {
            do {
                let kuralData = try Data(contentsOf: kuralURL)
                let thirukkuralData = try JSONDecoder().decode(ThirukkuralData.self, from: kuralData)
                kurals = thirukkuralData.kural
                
                let detailData = try Data(contentsOf: detailURL)
                details = try JSONDecoder().decode(DetailData.self, from: detailData)
            } catch {
                print("Error loading data: \(error)")
            }
        }
    }
    
    func generateRandomKural() {
        var newRandomKural = kurals.randomElement()
        while newRandomKural?.Number == kuralOfTheDay?.Number {
            newRandomKural = kurals.randomElement()
        }
        randomKural = newRandomKural
    }
    
    private func setKuralOfTheDay() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let totalKurals = kurals.count
        let dayNumber = calendar.ordinality(of: .day, in: .era, for: today) ?? 0
        let index = (dayNumber % totalKurals) - 1
        if index >= 0 && index < kurals.count {
            kuralOfTheDay = kurals[index]
        }
    }
}
