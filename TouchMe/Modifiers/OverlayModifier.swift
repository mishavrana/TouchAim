//
//  OverlayModifier.swift
//  TouchMe
//
//  Created by Misha Vrana on 10.05.2023.
//

import SwiftUI

struct OverlayModifier<OverlayView: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    @ViewBuilder var overlayView: () -> OverlayView
    
    init(isPresented: Binding<Bool>, @ViewBuilder overlayView: @escaping () -> OverlayView) {
            self._isPresented = isPresented
            self.overlayView = overlayView
        }
    
    func body(content: Content) -> some View {
        content.overlay(isPresented ? overlayView() : nil)
    }
}

extension View {
    func popup<OverlayView: View>(isPresented: Binding<Bool>,
                                  blurRadius: CGFloat = 3,
                                  blurAnimation: Animation? = .linear,
                                  @ViewBuilder overlayView: @escaping () -> OverlayView) -> some View {
        withAnimation(blurAnimation) {
            blur(radius: isPresented.wrappedValue ? blurRadius : 0)
                .allowsHitTesting(!isPresented.wrappedValue)
                .overlay(isPresented.wrappedValue ? Color.black.opacity(0.4): Color.black.opacity(0))
                .modifier(OverlayModifier(isPresented: isPresented, overlayView: overlayView))
        }
        
    }
}

