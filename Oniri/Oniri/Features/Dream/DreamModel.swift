//
//  DreamModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 15/07/2025.
//

import Foundation

struct Dream {
    
    var id = UUID()
    var title: String
    var subtitle: String
    var history: History
    var powers: Powers
    var card: [Cards]
    var isSuccessful: Bool
    
    init(title: String, subtitle: String, history: History, powers: Powers, card: [Cards], isSuccessful: Bool) {
        self.title = title
        self.subtitle = subtitle
        self.history = history
        self.powers = powers
        self.card = card
        self.isSuccessful = isSuccessful
    }
}
