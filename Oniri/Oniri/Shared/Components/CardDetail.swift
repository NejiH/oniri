//
//  CardDetail.swift
//  Oniri
//
//  Created by Sebastien Besse on 18/07/2025.
//

import SwiftUI

struct CardDetail: View {
    var body: some View {
        ZStack{
            Image("verso-card")
                .resizable()
                .scaledToFit()
                .shadow(color: .black.opacity(0.6), radius: 12, x: 10, y: 20)
            VStack{
                Text("Il était une fois une artéfiacte qui était si puissant que cela rendez toutes les personnes qui posait leur regard sur la carte qui devint d'une extrême patience")
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 80)
           
        }
    }
}

#Preview {
    CardDetail()
}
