//
//  OnboardingView.swift
//  Oniri
//
//  Created by Arnaud Hayon on 15/07/2025.
//

import SwiftUI

struct OnboardingViewModelOld: View {
    
    @State private var currentPage = 0
    @State private var isOnboardingCompleted = false
    
    var body: some View {
        
        let currentOnboarding = onboarding[currentPage]
        
        VStack {
            if !isOnboardingCompleted {
                VStack {
                    ProgressView(value: Float(currentPage + 1), total: Float(onboarding.count))
                        .accentColor(.darkGreen)
                        .frame(width: 300, height: 100)
                        .padding(.top, 50)
                    
                    Image(currentOnboarding.icone)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    
                    Spacer()
                    
                    VStack (alignment: .leading) {
                        Text(currentOnboarding.title)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .font(Font.custom("DelaGothicOne-Regular", size: 30))
                            .foregroundStyle(Color(currentOnboarding.textColor))
                            .fontWeight(.bold)
                        
                        Text(currentOnboarding.text)
                            .foregroundStyle(Color(currentOnboarding.textColor))
                        
                    }
                    .frame(width: 320)
                    
                    Spacer()
                }
                .frame(width: .infinity, height: 700)
                
                Button(action: {
                    if currentPage == onboarding.count - 1 {
                        isOnboardingCompleted = true
                    } else {
                        
                        currentPage += 1
                    }
                }) {
                    HStack {
                        if currentPage != onboarding.count - 1 {
                            Text("Suivant")
                        } else {
                            Text("Commencer")
                        }
                    }
                }
                .padding()
                .frame(width: 120, height: 50)
                .font(Font.custom("InstrumentSans-Bold", size: 16))
                .background(Color(currentOnboarding.buttonColor))
                .foregroundColor(Color(currentOnboarding.buttonTextColor))
                .cornerRadius(30)
                .padding(.top, 50)
                .padding(.bottom, 50)
                .padding(.leading, 220)
                
            } else {
                LandingPageView()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(currentOnboarding.backgroundColor))
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingViewModelOld()
}
