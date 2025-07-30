//
//  SuccessTransitionModelView.swift
//  Oniri
//
//  Created by Arnaud Hayon on 30/07/2025.
//

import Foundation
import SwiftUI

@Observable
class SuccessTransitionModelView {
    var isBack: Bool = false

    func goBack() {
        isBack = true
    }
    
    var successCards: Image {
        return Image("cards-success")
    }
    
    var successText: String {
        let text = "Félicitations, vous venez de récolter une série de trois artéfacts !\n\nDécouvrez ce que les rêves que vous avez traversé disent de votre personnalité."
        
        return text
    }
    
    var backgroundCard: Image {
        return Image("card-empathie-noborder")
    }
    
}
