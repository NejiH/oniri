//
//  CollectionViewModel.swift
//  Oniri
//
//  Created by apprenant152 on 17/07/2025.
//

import Foundation

@Observable
class CollectionViewModel{
    static let shared = CollectionViewModel()
    let collectionM = cardsCollection
    var isBack = false
    
    var collectionCardsDislocked : [Cards] {
        return collectionM.cards.filter{!$0.isLocked}.reversed()
    }
    
    func unlockCard(at index: Int) {
          if cardsCollection.cards.indices.contains(index) {
              cardsCollection.cards[index].isLocked = false
          }
      }
    
    func goBack(){
     isBack = true
    }
     
}
