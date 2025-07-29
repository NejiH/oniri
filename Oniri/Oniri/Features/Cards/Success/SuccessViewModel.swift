//
//  SuccessViewModel.swift
//  Oniri
//
//  Created by Sebastien Besse on 18/07/2025.
//

import Foundation

@Observable
class SuccessViewModel{
    var model: SuccessModel
    var isBack : Bool = false
    let collectionVM = CollectionViewModel.shared
    
    init(from dreamVM: DreamViewModel) {
        let dream = dreamVM.dream
        let card = dream.card.first ?? Cards(name: "Empathie", image: "card-empathie", description: "Pas de carte disponible", isLocked: false)
        
        self.model = SuccessModel(
            card: card,
            description: "Tu as complété l’exploration du rêve \(dream.title) et obtenu la carte \(card.name)."
        )
    }
    
    func goBack(){
     isBack = true
    }
    
    func addCardCollection(){
        collectionVM.unlockCard(at: 5)
    }
}
