//
//  CardsModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 15/07/2025.
//

import Foundation

class Cards {
    var id = UUID()
    var name: String
    var image: String
    var description: String
    var isLocked: Bool = false
    
    init(id: UUID = UUID(), name: String, image: String, description: String, isLocked: Bool) {
        self.id = id
        self.name = name
        self.image = image
        self.description = description
        self.isLocked = isLocked
    }
}
