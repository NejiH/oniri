//
//  SuccessTransitionView.swift
//  Oniri
//
//  Created by Arnaud Hayon on 30/07/2025.
//

import SwiftUI

struct SuccessTransitionView: View {
    
    @State var viewModel =  SuccessTransitionModelView()
    
    var body: some View {
        if !viewModel.isBack {
            ZStack {
                //MARK: -Background
                backgroundSuccess
                    .ignoresSafeArea()
                backgroundColor
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing:10){
                    //MARK: Titre Félicitations
                    contentText
                    Spacer()
                    
                    //MARK: Cartes
//                    imageCards
                


                    
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
            SuccessEndView()
        }
       
        
    }
    
    var backgroundSuccess: some View {
        viewModel.backgroundCard
    }
    
    var backgroundColor: some View {
        Rectangle()
            .fill(.darkGreen)
            .opacity(0.8)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var contentText: some View {
        VStack (spacing: 10){
            Rectangle()
                .fill(.softPink)
                .frame(width: 200, height: 2)
            
            //MARK: Titre
            Text("DÉCOUVRE TA PERSONNALITÉ")
                .font(.custom("DelaGothicOne-Regular", size: 30))
                .foregroundStyle(.primaryBeige)
                .bold()
                .textCase(.uppercase)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 60)
    }
    
    var textSuccessEnd: some View {
        Text(viewModel.successText)
            .foregroundStyle(.primaryBeige)
            .font(.system(size: 22))
            .fontWeight(.bold)
            .padding()
            .frame(width: 400, height: .infinity)
            .background(
                Color(.darkGreen)
            )
    }
    
    var buttonBack: some View {
        Button {
            viewModel.goBack()
        } label: {
            Text("Ma personnalité")
                .foregroundStyle(.dreamBlack)
                .bold()
                .padding()
                .background{
                    Capsule()
                        .fill(.softPink)
                        .frame(width: 150)
                }
        }
        .padding(.vertical, 10)
        .padding(.bottom, 50)
    }
    
}

#Preview {
    SuccessTransitionView()
}
