//
//  PowersView.swift
//  Oniri
//
//  Created by Arnaud Hayon on 22/07/2025.
//

import SwiftUI

struct PowersView: View {
    
    @State var isActivated: Bool = false
    
    
    var body: some View {
        Button(action: {
            isActivated.toggle()
        }) {
            if isActivated {
                ZStack {
                    Image("button-power-dark")
                    HStack(spacing: 50) {
                        MagicPenView()
                        XRayView()
                    }
                    .offset(y: -50)
                    .padding()
                }
            } else {
                Image("button-power-light")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
}
#Preview {
    PowersView()
}
