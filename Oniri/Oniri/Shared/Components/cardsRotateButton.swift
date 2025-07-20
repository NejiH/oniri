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
    var body: some View {
        VStack{
            Button {
                withAnimation {
                    isShowVerso.toggle()
                }
                withAnimation(Animation.easeOut(duration: 1.5)) {
                    rotation = 360
                }
            } label: {
                if isShowVerso{
                    CardDetail()
                }else{
                    Image("card-patience")
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
    CardsRotateButton()
}
