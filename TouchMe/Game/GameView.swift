//
//  GameView.swift
//  TouchMe
//
//  Created by Misha Vrana on 08.05.2023.
//

import SwiftUI

struct GameView: View {
    @State private var isBouncing = false
    @EnvironmentObject var touchGame: TouchGame
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    header
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .padding(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
                
                Spacer()
                
                GeometryReader { proxy in
                    VStack {
                        figure
                            .onTapGesture {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.2)) {
                                    isBouncing.toggle()
                                }
                                touchGame.handleGame(screenWidth: proxy.size.width, screenHeight: proxy.size.height)
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .position(touchGame.position == nil ? CGPoint(x: geometry.size.width/2, y: geometry.size.height/2) : touchGame.position!)
                }
                
                
                Spacer()
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        startOrRestart
                    }
                    .padding()
                    .font(.system(size:40))
                }
                .frame(maxWidth: .infinity)
                
            }
        }
        .popup(isPresented: $touchGame.isPlayedForTheFirstTime) {
            BottomPopupView {
                Rulse(isPresented: $touchGame.isPlayedForTheFirstTime)
            }
        }
    }
    
    var figure: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: Constants.figureWidth, height: Constants.figureHeight)
            .shadow(radius: Constants.figureShadow)
            .foregroundColor(.blue)
            .scaleEffect(isBouncing ? 1.2 : 1.0)
    }
    
    var header: some View {
        HStack() {
            HStack {
                Text("Time left:")
                TimerView(isDiactivated: touchGame.timerIsDeactivated)
            }
            Spacer()
            Text("Score: \(touchGame.score)")
        }
    }
    
    var startOrRestart: some View {
        Button {
            touchGame.showStartButton ? startGame() : restartGame()
        } label: {
            Image(systemName: touchGame.showStartButton ? "play.fill" : "restart")
        }
    }
    
    private func restartGame() {
        touchGame.restartGame()
    }
    
    private func startGame() {
        touchGame.startGame()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
