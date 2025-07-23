//
//  SuccesView.swift
//  Oniri
//
//  Created by Sebastien Besse on 18/07/2025.
//

import SwiftUI

struct SuccesView: View {
    @State var successVM : SuccessViewModel
    var body: some View {
        ZStack{
            
            //MARK: Background
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
                Text(successVM.model.description)
                    .foregroundStyle(.primaryBeige)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                //MARK: Carte
                CardsRotateButton(descriptionCard: successVM.model.card.description, imageCard: successVM.model.card.image)
                    .shadow(color: .black.opacity(0.6), radius: 12, x: 10, y: 20)
                    .padding(.leading, 8)
                    
                //MARK: Boutton
                Button {
                    print("retour")
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
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

//MARK: Preview
#Preview {
    let testQuestions = [
        Question(question: "Oui monsieur ", choice: ["Oui", "Non"]),
        Question(question: "Oui madame ", choice: ["Oui", "Non"])
    ]
    let testHistory = History(title: "Route des Brumes", subtitle: "", narrative: "blabklablab", image: [""], questions: testQuestions)
    let testPowers = Powers.magicPen
    let testCard = Cards(name: "Flamme Onirique", image: "card-patience", description: "Une carte qui vous offre une extrême patience afin de braver toutes formes de stresse.", isLocked: false)
    let testDream = Dream(
        title: "Le monde d'hurul",
        subtitle: "Le début d'une aventure",
        history: testHistory,
        powers: testPowers,
        card: [testCard],
        isSuccessful: true
    )
    let dreamVM = DreamViewModel(dream: testDream)
    let successVM = SuccessViewModel(from: dreamVM)

    SuccesView(successVM: successVM)
}
        
 
