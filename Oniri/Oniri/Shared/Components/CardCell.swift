//
//  CardCell.swift
//  Oniri
//
//  Created by Sebastien Besse on 28/07/2025.
//

import SwiftUI

struct CardCell: View {
    let card : Cards
    var body: some View {
        VStack{
            Image(card.image)
                .resizable()
                .scaledToFill()
                .shadow(radius: 10, x: 10, y: 10)
                .frame(width: 300, height: 300)
                .padding()
        }
    }
}

#Preview {
    CardCell(card:  cardsCollection.cards[0])
}
