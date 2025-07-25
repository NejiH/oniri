//
//  DreamViewModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 15/07/2025.
//

import Foundation

@Observable
class DreamViewModel{
    var dream: Dream
    
    init(dream: Dream) {
        self.dream = dream
    }
    
    // Simulation d'une fin de mission
    func completeDream(isSuccessful : Bool, card: Cards){
        let _ = Dream(title: dream.title, subtitle: dream.subtitle, history: dream.history, powers: dream.powers, card: dream.card, isSuccessful: dream.isSuccessful)
    }
}
