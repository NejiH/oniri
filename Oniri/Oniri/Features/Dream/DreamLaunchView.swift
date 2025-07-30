//
//  DreamLaunchView.swift
//  Oniri
//
//  Created by Chabane on 29/07/2025.
//

import SwiftUI

struct DreamLaunchView: View {
    
    @State private var viewModel = HistoryViewModel()
    @State var successVM: SuccessViewModel
    @State private var showDreamView = false
    
    var body: some View {
        if showDreamView {
            DreamView(successVM: successVM)
                .transition(.opacity)
                .toolbar(.hidden)
                .navigationBarBackButtonHidden(true)
               
        } else {
            ZStack {
                // L' image du rêve
                Image(viewModel.currentHistory.image?["start"] ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width * 1.5,
                           height: UIScreen.main.bounds.height * 1.5)
                    .offset(x: -UIScreen.main.bounds.width * 0.0,
                            y: -UIScreen.main.bounds.height * 0.0)
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Le titre du rêve (à voir si on le met en vert comme sur maquette)
                Text(viewModel.currentHistory.maintitle ?? "")
                    .font(Font.custom("DelaGothicOne-Regular", size: 22))
                    .textCase(.uppercase)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .background(
                        Color(.softBeige)
                            .opacity(0.8)
                    )
                    .foregroundColor(.black)
            }
            .transition(.opacity)
            // Délai de 2.0 secondes avant la transition vers le rêve
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    // Animation fade classique linéaire
                    withAnimation(.linear(duration: 1.0)) {
                        showDreamView = true
                    }
                }
            }
            .toolbar(.hidden)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    DreamLaunchView(successVM: successVM)
}
