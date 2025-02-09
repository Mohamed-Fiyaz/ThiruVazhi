//
//  DetailData.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import Foundation

struct DetailData: Codable {
    let tamil: String
    let section: Section
}

struct Section: Codable {
    let tamil: String
    let detail: [Book]
}

struct Book: Codable {
    let name: String
    let transliteration: String
    let translation: String
    let number: Int
    let chapterGroup: ChapterGroup
}

struct ChapterGroup: Codable {
    let tamil: String
    let detail: [ChapterGroupDetail]
}

struct ChapterGroupDetail: Codable {
    let name: String
    let transliteration: String
    let translation: String
    let number: Int
    let chapters: Chapters
}

struct Chapters: Codable {
    let tamil: String
    let detail: [Chapter]
}

struct Chapter: Codable, Identifiable {
    let name: String
    let translation: String
    let transliteration: String
    let number: Int
    let start: Int
    let end: Int
    
    var id: Int { number }
}
