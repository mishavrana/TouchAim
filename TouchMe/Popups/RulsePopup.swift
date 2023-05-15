//
//  Popup.swift
//  TouchMe
//
//  Created by Misha Vrana on 10.05.2023.
//

import SwiftUI

struct Rulse: View {
    @Binding var isPresented: Bool
    var body: some View {
        VStack(alignment: .leading) {
            Text("Game rules")
                .font(.title)
                .padding(.bottom)
            Text("Tap the aim 10 times or more in 7 seconds or faster to win the game")
            hideButton
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
    
    var hideButton: some View {
        Button {
            withAnimation(.easeInOut) {
                isPresented = false
            }
        } label: {
            ZStack {
                Text("Clear")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
        }
    }
}

struct Popup_Previews: PreviewProvider {
    static var previews: some View {
        Rulse(isPresented: Binding.constant(true))
    }
}
