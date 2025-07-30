//
//  SuccesView.swift
//  Oniri
//
//  Created by Sebastien Besse on 18/07/2025.
//

import SwiftUI

struct SuccesView: View {
    
    @State var successVM: SuccessViewModel
    
    var body: some View {
        if !successVM.isBack{
            ZStack{
                //MARK: Background
                backgroundSuccess
                .ignoresSafeArea()
                VStack(alignment: .center, spacing: 10){
                    //MARK: Contient tout les textes
                    contentText
                    Spacer()
                    //MARK: Carte
                    CardsRotateButton(descriptionCard: successVM.model.card.description, imageCard: successVM.model.card.image)
                        .shadow(color: .black.opacity(0.6), radius: 12, x: 10, y: 20)
                        .padding(.leading, 8)
                    //MARK: Button
                    buttonBack
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }else {
            SuccessTransitionView()
        }
    }
    //MARK: Composants de la vue Body
    var backgroundSuccess: some View {
        VStack(spacing: -1){
            Rectangle()
                .fill(.sofGreen)
            Rectangle()
                .fill(.softPink)
        }
    }
    var contentText: some View {
        VStack{
            Rectangle()
                .fill(.softPink)
                .frame(width: 200, height: 2)
            //MARK: Titre
            Text("Félicitations")
                .textCase(.uppercase)
                .font(.custom("DelaGothicOne-Regular", size: 28))
                .foregroundStyle(.primaryBeige)
                .bold()
            
            //MARK: Description
            Text(successVM.model.description)
                .foregroundStyle(.primaryBeige)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }

    }
    
    var buttonBack: some View {
        Button {
            successVM.goBack()
            successVM.addCardCollection()
        } label: {
            Text("Terminer")
                .foregroundStyle(.primaryBeige)
                .bold()
                .padding()
                .background{
                    Capsule()
                        .fill(.darkGreen)
                        .frame(width: 150)
                }
        }
        .padding(.vertical, 10)
    }
}

//MARK: Preview
#Preview {
    SuccesView(successVM: successVM)
}
