//
//  ThirukkuralData.swift
//  ThiruVazhi
//
//  Created by Mohamed Fiyaz on 09/02/25.
//

import Foundation

struct Kural: Codable, Identifiable {
    let Number: Int
    let Line1: String
    let Line2: String
    let Translation: String
    let mv: String
    let sp: String
    let mk: String
    let explanation: String
    let couplet: String
    let transliteration1: String
    let transliteration2: String
    
    var id: Int { Number }
}

struct ThirukkuralData: Codable {
    let kural: [Kural]
}

