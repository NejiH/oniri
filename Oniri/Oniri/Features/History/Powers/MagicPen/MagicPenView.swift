//
//  MagicVandView.swift
//  Oniri
//
//  Created by Arnaud Hayon on 22/07/2025.
//

import SwiftUI

struct MagicPenView: View {
    
    @State var isActivated: Bool = false
    
    var body: some View {
        Button(action: {
            isActivated.toggle()
            }) {
                if isActivated {
                    Image("button-magic-wand-dark")
                        
                } else {
                    Image("button-magic-wand-light")
                       
                }
            }
    }
}

#Preview {
    MagicPenView()
}
