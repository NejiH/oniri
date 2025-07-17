//
//  SuccessModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 17/07/2025.
//

import Foundation

struct SuccessModel {
    var id = UUID()
    var title: String
    var card: [Cards]
    var description: String
    
    init(id: UUID = UUID(), title: String, card: [Cards], description: String) {
        self.id = id
        self.title = title
        self.card = card
        self.description = description
    }
}
