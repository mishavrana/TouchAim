//
//  BottomPopupView.swift
//  TouchMe
//
//  Created by Misha Vrana on 10.05.2023.
//

import SwiftUI

struct BottomPopupView<Content: View>: View {
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            VStack() {
                Spacer()
                content()
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
                    .background(Color.white)
                    .cornerRadius(radius: 16, corners: [.topLeft, .topRight])
            }
            .edgesIgnoringSafeArea([.bottom])
            .frame(maxWidth: .infinity)
        }
        .transition(.move(edge: .bottom))
    }
}
