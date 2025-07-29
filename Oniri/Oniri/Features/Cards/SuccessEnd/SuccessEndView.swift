//
//  SuccessEndView.swift
//  Oniri
//
//  Created by Arnaud Hayon on 29/07/2025.
//

import SwiftUI

struct SuccessEndView: View {
    
    @State var viewModel =  SuccessEndViewModel()
    
    var body: some View {
        // barre
        // Titre "Félicitations"
        // Image avec les visages
        // Image cards-success
        // Text fin de jeu
        // Bouton retour
        if !viewModel.isBack {
            ZStack {
                //MARK: -Background
                backgroundSuccess
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing:10){
                    //MARK: Titre Félicitations
                    contentText
                    Spacer()
                    
                    //MARK: Cartes
                    imageCards
                


                    
                    //MARK: Texte
                    textSuccessEnd
                    
                    Spacer()
                    
                    //MARK: Button
                    buttonBack
                    

                }
                .padding()
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            LandingPageView()
        }
       
        
    }
    
    var backgroundSuccess: some View {
        VStack(spacing: -1){
            Rectangle()
                .fill(.sofGreen)
            Rectangle()
                .fill(.softPink)
        }
    }
    
    var contentText: some View {
        VStack (spacing: 10){
            Rectangle()
                .fill(.softPink)
                .frame(width: 200, height: 2)
            
            //MARK: Titre
            Text("PERSONNALITÉ")
                .font(.custom("DelaGothicOne-Regular", size: 30))
                .foregroundStyle(.primaryBeige)
                .bold()
                .textCase(.uppercase)
            HStack {
                Text("Vous êtes")
                 Text("bienveillant·e")
                    .bold()
            }
            .foregroundStyle(.primaryBeige)
            .font(.system(size: 22))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 30)
            .padding(.top, 20)
            
        }
    }
    
   
    
    var imageCards: some View {
        viewModel.successCards
            .resizable()
            .scaledToFill()
            .frame(maxWidth: 360, maxHeight: 270)
        
    }
    
    var textSuccessEnd: some View {
        Text(viewModel.successText)
            .frame(width: 320, height: 200)
    }
    
    var logoSuccessEnd: some View {
        viewModel.successLogo
            .resizable()
            .frame(width:128, height: 123)
    }
    
    var buttonBack: some View {
        Button {
            viewModel.goBack()
        } label: {
            Text("Retour")
                .foregroundStyle(.primaryBeige)
                .bold()
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.sofGreen)
                        .frame(width: 150)
                }
        }
        .padding(.vertical, 10)
    }
    
}

#Preview {
    SuccessEndView()
}
