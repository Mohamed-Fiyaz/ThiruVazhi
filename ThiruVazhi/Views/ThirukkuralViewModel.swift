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
    @Published var showTamilText = true
    @Published var randomKural: Kural?
    @Published var expandedFavoriteKurals = false
    @Published var expandedFavoriteChapters = false
    @Published var filteredKurals: [Kural] = []
    
    private var searchWorkItem: DispatchWorkItem?
    
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
    
    func performSearch(query: String) {
        searchWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            if query.isEmpty {
                DispatchQueue.main.async {
                    self.filteredKurals = []
                }
                return
            }
            
            let filtered = self.kurals.filter { kural in
                kural.Translation.localizedCaseInsensitiveContains(query) ||
                kural.explanation.localizedCaseInsensitiveContains(query)
            }
            
            DispatchQueue.main.async {
                self.filteredKurals = filtered
            }
        }
        
        searchWorkItem = workItem
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.3, execute: workItem)
    }
    
    init() {
        loadData()
        setKuralOfTheDay()
        generateRandomKural()
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
