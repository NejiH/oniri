//
//  LandingPageViewModel.swift
//  Oniri
//
//  Created by apprenant152 on 30/07/2025.
//

import Foundation

@Observable
class LandingPageViewModel {
    var isCollection = false
    
    func goCollection() {
        isCollection = true
    }
}
