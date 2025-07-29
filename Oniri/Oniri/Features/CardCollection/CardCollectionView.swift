//
//  CardCollectionView.swift
//  Oniri
//
//  Created by Arnaud Hayon on 15/07/2025.
//

import SwiftUI
import CardCarousel

struct CardCollectionView: View {
    @State var cardsCollectionVM = CollectionViewModel()
    var body: some View {
        if !cardsCollectionVM.isBack == true{
            ZStack{
                VStack{
                    //MARK: Oeuil
                    Image("top-eye")
                        .resizable()
                        .frame(width: 75, height: 69.99)
                        .padding(.top)
                
                    //MARK: Titre de la vue et le deck
                    contentText
                    Spacer()
  
                    //MARK: Carousel
                    cardsCarousel
    
                    //MARK: Boutton
                    buttonBack
                }
                .padding(.vertical, 45)
            }
            .navigationBarBackButtonHidden(true)
            //MARK: Background
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background{
                Rectangle()
                    .fill(.primaryBeige)
                Image("CadreDecoratif")
            }
            .ignoresSafeArea(.all)
        }else{
            LandingPageView()
        }
    }
    
    //MARK: Propriété calculer retournant une vue
    var contentText: some View{
        VStack(spacing: -1){
            Rectangle()
                .frame(width: 200, height: 1)
            HStack{
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.softPink)
                Text("Collection")
                    .textCase(.uppercase)
                    .font(.custom("DelaGothicOne-Regular", size: 28))
                    .padding(.horizontal, 4)
     
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.softPink)
            }
            //MARK: Contenue du deck
            Text("Deck: \(cardsCollectionVM.collectionCardsDislocked.count)/\(cardsCollectionVM.collectionM.cards.count)")
                .font(.title3)
                .foregroundStyle(.midGreen)
        }
    }
    
    var cardsCarousel: some View{
        VStack{
            Carousel(cardsCollectionVM.collectionCardsDislocked, id: \.self, isLooping: true, content: { item in
                VStack{
                    CardCell(card: item )
                        .padding(.bottom, 30)
                }
            })
        }
    }
    
    var buttonBack: some View{
        Button {
            cardsCollectionVM.goBack()
        } label: {
            Text("Retour")
                .foregroundStyle(.primaryBeige)
                .padding()
                .frame(width: 120, height: 40)
                .background{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.midGreen)
            }
        }
    }
}

#Preview {
    CardCollectionView()
}
