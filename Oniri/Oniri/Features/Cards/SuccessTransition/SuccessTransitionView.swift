//
//  SuccessTransitionView.swift
//  Oniri
//
//  Created by Arnaud Hayon on 30/07/2025.
//

import SwiftUI
import UIKit
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
                    successTextUIKit
                        .padding(-30)
                    
//                    textSuccessEnd
                    
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
    
//    var textSuccessEnd: some View {
//        Text(viewModel.successText)
//            .foregroundStyle(.primaryBeige)
//            .font(.system(size: 22))
//            .fontWeight(.bold)
//            .background(
//                Color(.darkGreen)
//            )
//    }
    
    var successTextUIKit: some View {
        VStack{
            SuccessDescriptionView()
                .font(.system(size: 22))
                .fontWeight(.bold)
                .background(
                    Color(.darkGreen)
                )
                .frame(maxWidth: .infinity, maxHeight: 200, alignment: .leading)
              
                
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(Color.darkGreen)
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
struct SuccessDescriptionView: UIViewRepresentable {
    @State var viewModel =  SuccessTransitionModelView()
    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        let label = UILabel()
        label.tag = 100  // Pour le retrouver plus tard
      
        label.text = viewModel.successText
        label.textColor = .primaryBeige
        label.font = .systemFont(ofSize: 22)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(label)
    
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 18),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -18),
            label.topAnchor.constraint(equalTo: container.topAnchor),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Retrouver le UILabel via son tag
        if let label = uiView.viewWithTag(100) as? UILabel {
            label.text = viewModel.successText
        }
    }
}
#Preview {
    SuccessTransitionView()
}


