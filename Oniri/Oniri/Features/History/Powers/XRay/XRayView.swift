//
//  MagicEyeView.swift
//  Oniri
//
//  Created by Arnaud Hayon on 22/07/2025.
//

import SwiftUI

struct XRayView: View {
    
    @State var isActivated: Bool = false
    
    var body: some View {
        Button(action: {
            isActivated.toggle()
        }) {
            if isActivated {
                Image("button-eye-dark")
                
                // Image for when enabled
            } else {
                Image("button-eye-light")
                 
                // Image for when disabled
            }
        }
    }
}

#Preview {
    XRayView()
}
