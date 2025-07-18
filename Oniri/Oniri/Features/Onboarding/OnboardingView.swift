//
//  OnboardingView.swift
//  Oniri
//
//  Created by Arnaud Hayon on 18/07/2025.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack {
            if !viewModel.isOnboardingCompleted {
                onboardingContent
                nextButton
            } else {
                LandingPageView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(viewModel.currentOnboarding.backgroundColor))
        .ignoresSafeArea()
    }
    
    // MARK: - Tous les éléments de lq page qui sont des vues
    var onboardingContent: some View {
        VStack {
            progressBar
            onboardingImage
            Spacer()
            textContent
            Spacer()
        }
        .frame(width: .infinity, height: 700)
    }
    
    var progressBar: some View {
        ProgressView(value: viewModel.progressValue, total: viewModel.totalPages)
            .accentColor(.darkGreen)
            .frame(width: 300, height: 100)
            .padding(.top, 50)
    }
    
    var onboardingImage: some View {
        Image(viewModel.currentOnboarding.icone)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
    }
    
    var textContent: some View {
        VStack(alignment: .leading) {
            Text(viewModel.currentOnboarding.title)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .font(Font.custom("DelaGothicOne-Regular", size: 30))
                .foregroundStyle(Color(viewModel.currentOnboarding.textColor))
                .fontWeight(.bold)
            
            Text(viewModel.currentOnboarding.text)
                .foregroundStyle(Color(viewModel.currentOnboarding.textColor))
        }
        .frame(width: 320)
    }
    
    var nextButton: some View {
        Button(action: {
            viewModel.nextPage()
        }) {
            HStack {
                Text(viewModel.buttonText)
            }
        }
        .padding()
        .frame(width: 120, height: 50)
        .font(Font.custom("InstrumentSans-Bold", size: 16))
        .background(Color(viewModel.currentOnboarding.buttonColor))
        .foregroundColor(Color(viewModel.currentOnboarding.buttonTextColor))
        .cornerRadius(30)
        .padding(.top, 50)
        .padding(.bottom, 50)
        .padding(.leading, 220)
    }
}

#Preview {
    OnboardingView()
}
