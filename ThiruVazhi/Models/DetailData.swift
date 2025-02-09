//
//  DetailData.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import Foundation

struct Chapter: Codable, Identifiable {
    let name: String
    let translation: String
    let transliteration: String
    let number: Int
    let start: Int
    let end: Int
    
    var id: Int { number }
}

struct ChapterGroup: Codable {
    let tamil: String
    let detail: [Chapter]
}

struct Section: Codable {
    let tamil: String
    let detail: [BookDetail]
}

struct BookDetail: Codable {
    let name: String
    let transliteration: String
    let translation: String
    let number: Int
    let chapterGroup: ChapterGroup
}

struct DetailData: Codable {
    let tamil: String
    let section: Section
}
