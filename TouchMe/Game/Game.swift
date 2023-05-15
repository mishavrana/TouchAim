//
//  TouchGame.swift
//  TouchMe
//
//  Created by Misha Vrana on 08.05.2023.
//

import Foundation

struct Game {
    var isStarted = false
    var isPlayedForTheFirstTime = true
    var score: Int
    var startTime: Date?
    
    mutating func startGame() {
        isStarted = true
        startTime = Date.now
    }
    
    mutating func assignAPoint() {
        score += 1
    }
    
    init(score: Int, gameTimeInSeconds: Int, isPalyedForTheFirstTime: Bool = true) {
        self.score = score
        self.isPlayedForTheFirstTime = isPalyedForTheFirstTime
    }
}
