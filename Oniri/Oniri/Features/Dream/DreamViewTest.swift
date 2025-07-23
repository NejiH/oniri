//
//  DreamViewTest.swift
//  Oniri
//
//  Created by Chabane on 18/07/2025.
//

import SwiftUI

struct DreamViewTest: View {
    var body: some View {
      ZStack {
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
                  Text("NOM DU RÊVE")
                      .font(.title)
                      .bold()
                  Text(phase)
                  Text(longText)
                      .padding()
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

  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

  Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

  Excepteur sint occaecat

  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

  Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

  Excepteur sint occaecat
  
  """
}


#Preview {
    DreamViewTest()
}
