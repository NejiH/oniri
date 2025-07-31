//
//  SucessEndViewModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 29/07/2025.
//

import Foundation
import SwiftUI

@Observable
class SuccessEndViewModel {
    var isBack: Bool = false

    func goBack() {
        isBack = true
    }
    
    var successLogo: Image {
        return Image("icon-faces-light")
    }
    
    var successCards: Image {
        return Image("cards-success")
    }
    
    var successText: String {
        let text = "Vous avez avancé avec patience et fait preuve d’empathie, de douceur et d’écoute tout au long de votre aventure. Vous ne cherchez pas à imposer votre volonté, mais à comprendre l’autre, à ressentir avant d’agir.\n\nVous incarnez une présence stable et réconfortante. "
        
        return text
    }
    
}


