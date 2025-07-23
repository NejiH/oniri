//
//  SuccessViewModel.swift
//  Oniri
//
//  Created by Sebastien Besse on 18/07/2025.
//

import Foundation

class SuccessViewModel{
    var model: SuccessModel

     init(from dreamVM: DreamViewModel) {
         let dream = dreamVM.dream
         let card = dream.card.first ?? Cards(name: "Patience", image: "card-patience", description: "Pas de carte disponible", isLocked: false)

         self.model = SuccessModel(
             card: card,
             description: "Tu as complété l’exploration du rêve \(dream.title) et obtenu la carte \(card.name)."
         )
     }}
