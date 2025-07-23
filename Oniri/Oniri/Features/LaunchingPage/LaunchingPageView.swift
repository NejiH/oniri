//
//  LaunchingPageView.swift
//  Oniri
//
//  Created by Arnaud Hayon on 15/07/2025.
//

import SwiftUI

struct LaunchingPageView: View {
    var body: some View {
        ZStack{
            Image("logo-oniri")
                .resizable()
                .scaledToFit()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.launchGreen)
    }
}

#Preview {
    LaunchingPageView()
}
