//
//  DreamViewTest.swift
//  Oniri
//
//  Created by Chabane on 18/07/2025.
//

import SwiftUI

struct DreamViewTest: View {
    
    @State private var viewModel = HistoryViewModel()
    
    var body: some View {
      ZStack {
          Color.primaryBeige
              .ignoresSafeArea()
          // Le cadre décoratif
          Image("CadreDecoratif")
              .resizable()
              .scaledToFit()
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .ignoresSafeArea()
        
        // La vue du texte
          ScrollView {
              VStack() {
                Image("top-moon")
                  Rectangle()
                      .fill(.darkGreen)
                      .frame(width: 200, height: 1) // check dimensions
                  Text(viewModel.currentHistory.title)
                      .font(Font.custom("DelaGothicOne-Regular", size: 28))
                      .bold()
                  Text(viewModel.currentHistory.subtitle)
                  Text(viewModel.currentHistory.narrative[0])
                  Text(viewModel.currentHistory.questions ?? "C'est la fin")
                  Text(viewModel.currentHistory.answer?[0] ?? "Réponse 1")
                  Text(viewModel.currentHistory.answer?[1] ?? "Réponse 2")
                      
              }
              .padding(.horizontal, 24)
              .padding(.vertical, 32)
          }
        // l'effet pour le texte qui s'estompe
          .mask(
              LinearGradient(
                  gradient: Gradient(stops: [
                      .init(color: .clear, location: 0.0),   // Fade en haut
                      .init(color: .black, location: 0.05),  // 5% opaque
                      .init(color: .black, location: 0.95),  // 95% opaque
                      .init(color: .clear, location: 0.97)    // Fade en bas
                  ]),
                  startPoint: .top,
                  endPoint: .bottom
              )
          )
      }
  }

  let phase = "Pase sommeil"
  let longText = """
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
  
  """
}


#Preview {
    DreamViewTest()
}
