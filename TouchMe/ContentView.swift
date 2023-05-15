//
//  ContentView.swift
//  TouchMe
//
//  Created by Misha Vrana on 08.05.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var urlManager = URLManager()
    @EnvironmentObject var touchGame: TouchGame
    
    var body: some View {
        VStack {
            if let response = urlManager.response, let userStatus = touchGame.userStatus {
                WebViewWithNavigation(response: response, status: userStatus)
                    .environmentObject(urlManager)
                    .environmentObject(touchGame)
            } else {
                if !touchGame.isStarted && touchGame.userStatus != nil {
                    ProgressView()
                        .task {
                            do {
                                try await urlManager.getPlayerStatuses()
                            } catch {
                                print("Error is: \(error.localizedDescription)")
                            }
                        }
                } else {
                    GameView()
                        .environmentObject(touchGame)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
