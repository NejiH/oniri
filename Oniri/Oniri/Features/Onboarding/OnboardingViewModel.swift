//
//  ViewModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 18/07/2025.
//

import SwiftUI
import Foundation

@Observable
class OnboardingViewModel {
    
    // MARK: - Propriétés
    var currentPage = 0
    var isOnboardingCompleted = false
    
    // MARK: - Computed Properties
    var currentOnboarding: OnboardingModel {
        return onboarding[currentPage]
    }
    
    var buttonText: String {
        return currentPage == onboarding.count - 1 ? "Commencer" : "Suivant"
    }
    
    var progressValue: Float {
        return Float(currentPage + 1)
    }
    
    var totalPages: Float {
        return Float(onboarding.count)
    }
    
    // MARK: - Méthodes
    func nextPage() {
        if currentPage == onboarding.count - 1 {
            completeOnboarding()
        } else {
            currentPage += 1
        }
    }
    
    private func completeOnboarding() {
        isOnboardingCompleted = true
    }
    
    func resetOnboarding() {
        currentPage = 0
        isOnboardingCompleted = false
    }
}

//#Preview {
//    ViewModel()
//}
