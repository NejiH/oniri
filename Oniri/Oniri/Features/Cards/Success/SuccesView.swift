//
//  SuccesView.swift
//  Oniri
//
//  Created by Sebastien Besse on 18/07/2025.
//

import SwiftUI

struct SuccesView: View {
    var body: some View {
        ZStack{
            VStack(spacing: -1){
                Rectangle()
                    .fill(.sofGreen)
                Rectangle()
                    .fill(.softPink)
            }
            .ignoresSafeArea()
            VStack(alignment: .center, spacing: 10){
                Rectangle()
                    .fill(.softPink)
                    .frame(width: 200, height: 2)
                //MARK: Titre
                Text("Félicitations")
                    .font(.custom("DelaGothicOne-Regular", size: 46))
                    .foregroundStyle(.primaryBeige)
                    .bold()
                //MARK: Description
                Text("Tu as complété l’exploration et obtenu l'artefact du Rêve#1 !")
                    .foregroundStyle(.primaryBeige)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                //MARK: Carte
                CardsRotateButton()
                    .shadow(color: .black.opacity(0.6), radius: 12, x: 10, y: 20)
                    .padding(.leading, 8)
                    
                //MARK: Boutton
                Button {
                    print("retour")
                } label: {
                    Text("Retour")
                        .foregroundStyle(.primaryBeige)
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.sofGreen)
                                .frame(width: 150)
                        }
                }
                .padding(.vertical, 10)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SuccesView()
}
