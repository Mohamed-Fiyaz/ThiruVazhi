//
//  ThirukkuralViewModel.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import Foundation
import SwiftUI
import Combine

class ThirukkuralViewModel: ObservableObject {
    @Published var kurals: [Kural] = []
    @Published var details: DetailData?
    @Published var kuralOfTheDay: Kural?
    @Published var showTamilText = true
    @Published var randomKural: Kural?
    
    init() {
        loadData()
        setKuralOfTheDay()
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
        randomKural = kurals.randomElement()
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
