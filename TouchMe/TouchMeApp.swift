//
//  TouchMeApp.swift
//  TouchMe
//
//  Created by Misha Vrana on 08.05.2023.
//

import SwiftUI

@main
struct TouchMeApp: App {
    @StateObject var touchGame = TouchGame()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(touchGame)
        }
    }
}
