//
//  cardsRotateButton.swift
//  Oniri
//
//  Created by Sebastien Besse on 18/07/2025.
//

import SwiftUI

struct CardsRotateButton: View {
    @State var isShowVerso: Bool = false
    @State var rotation: Double = 0
    @State var rotationText: Double = 0
    var descriptionCard: String
    var imageCard: String
    var body: some View {
        VStack{
            Button {
                withAnimation(Animation.easeOut(duration: 1.5)) {
                    isShowVerso.toggle()
                }
                withAnimation(Animation.easeOut(duration: 1.5)) {
                    rotation = -180
                    rotationText = 180
                }
            } label: {
                if isShowVerso{
                    ZStack{
                        Image("verso-card")
                            .resizable()
                            .scaledToFit()
                            .shadow(color: .black.opacity(0.6), radius: 12, x: 10, y: 20)
                        VStack{
                            Text(descriptionCard)
                                .multilineTextAlignment(.center)
                                .rotation3DEffect(.degrees(isShowVerso ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                        }
                        .padding(.horizontal, 80)
                       
                    }
                }else{
                    Image(imageCard)
                        .resizable()
                        .scaledToFit()
                }
              
            }
            .rotation3DEffect(.degrees(isShowVerso ? rotation : 0), axis: (x: 0, y: 1, z: 0))
            .contentShape(Rectangle())

        }
    }
}

#Preview {
    CardsRotateButton(descriptionCard: "Il était une fois une artéfiacte qui était si puissant que cela rendez toutes les personnes qui posait leur regard sur la carte qui devint d'une extrême patience", imageCard: "card-patience")
}
