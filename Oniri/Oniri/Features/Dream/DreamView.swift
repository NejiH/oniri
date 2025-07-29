//
//  DreamView.swift
//  Oniri
//
//  Created by Chabane on 18/07/2025.
//

import SwiftUI

struct DreamView: View {
    
    @State private var viewModel = HistoryViewModel()
    @State private var selectedAnswer: Int? = nil
    @State var successVM: SuccessViewModel
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fond de couleur
                Color.primaryBeige
                    .ignoresSafeArea()
                
                // Le cadre décoratif
                Image("CadreDecoratif")
                    .resizable()
                    .scaledToFit()
                    .padding(5)
                    .ignoresSafeArea()
                
                // La vue du texte
                ScrollViewReader { value in
                    ScrollView {
                        VStack(spacing: 16) {
                            // Lune en haut
                            Image("top-moon")
                            
                            // Ligne de séparation
                            Rectangle()
                                .fill(.darkGreen)
                                .frame(width: 200, height: 1)
                            
                            // Le titre
                            Text(viewModel.currentHistory.title)
                                .textCase(.uppercase)
                                .font(Font.custom("DelaGothicOne-Regular", size: 22))
                                .bold()
                    
                            // Le sous-titre
                            Text(viewModel.currentHistory.subtitle)
                                .bold()
                            
                            
                            Spacer()
                            
                            // L'histoire
                            Text(viewModel.currentHistory.narrative[0])
                                .padding(10)
                            
                            Spacer()
                            
                            // La question
                            Text(viewModel.currentHistory.questions ?? "C'est la fin")
                                .textCase(.uppercase)
                                .font(Font.custom("DelaGothicOne-Regular", size: 15))
                                .bold()
                            
                            // Les choix de réponses
                            if viewModel.currentHistory.subtitle == "Fin" {
                                
                            } else {
                                HStack {
                                    
                                    // Choix 1
                                    Button(action: {
                                        withAnimation(.spring()) {
                                            selectedAnswer = (selectedAnswer == 1) ? nil : 1
                                        }
                                    }) {
                                        ZStack {
                                            Image("verso-card")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                            Text(viewModel.currentHistory.answer?[0] ?? "Réponse 1")
                                                .padding(.horizontal, 30)
                                        }
                                        .scaleEffect(selectedAnswer == 1 ? 1.15 : 1.0)
                                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedAnswer)
                                    }
                                    
                                    // Choix 2
                                    Button(action: {
                                        withAnimation(.spring()) {
                                            selectedAnswer = (selectedAnswer == 0) ? nil : 0
                                        }
                                    }) {
                                        ZStack {
                                            Image("verso-card")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                            Text(viewModel.currentHistory.answer?[1] ?? "Réponse 2")
                                                .padding(.horizontal, 30)
                                        }
                                        .scaleEffect(selectedAnswer == 0 ? 1.15 : 1.0)
                                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedAnswer)
                                    }
                                }
                            }
                            
                            // Bouton "Valider"
                            if viewModel.currentHistory.subtitle != "Fin"{
                                if selectedAnswer != nil  {
                                    Button(
                                        action: {
                                            viewModel.updateCurrentHistory(answerIndex: 0)
                                            selectedAnswer = nil
                                            withAnimation {
                                                value.scrollTo(0, anchor: .top)
                                            }
                                        }) {
                                            Text("Valider")
                                                .bold()
                                                .frame(width: 150)
                                                .padding()
                                                .background(Color.darkGreen)
                                                .foregroundColor(.white)
                                                .cornerRadius(40)
                                        }
                                }
                            } else {
                                NavigationLink(destination: SuccesView(successVM: successVM).navigationBarBackButtonHidden(true)) {
                                    Text("Terminer")
                                        .bold()
                                        .frame(width: 150)
                                        .padding()
                                        .background(Color.darkGreen)
                                        .foregroundColor(.white)
                                        .cornerRadius(40)
                                }
                            }
                            Spacer(minLength: 80)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 32)
                        .id(0)
                    }
                    // L’effet pour le texte qui s’estompe en haut et en bas
                    .mask(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .clear, location: 0.0),   // Fade en haut
                                .init(color: .black, location: 0.05),  // 5% opaque
                                .init(color: .black, location: 0.95),  // 95% opaque
                                .init(color: .clear, location: 0.97)   // Fade en bas
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    DreamView(successVM: successVM)
}
