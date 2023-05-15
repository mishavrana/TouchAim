//
//  TouchGame.swift
//  TouchMe
//
//  Created by Misha Vrana on 08.05.2023.
//

import Foundation

class TouchGame: ObservableObject {
    @Published private var game: Game = createTouchGame()
    @Published var position: CGPoint?
    @Published var timerIsDeactivated: Bool = true
    @Published var showStartButton: Bool = true
    
    var startTime: Date?
    var finishTime: Date?
    
    var userStatus: UserStatus?
    var isStarted: Bool {
        get { return game.isStarted }
    }
    var score: Int {
        get { game.score }
    }
    var isPlayedForTheFirstTime: Bool {
        get { game.isPlayedForTheFirstTime }
        set {
            game.isPlayedForTheFirstTime = newValue
            storeInUserDefaults()
        }
    }
    
    static func createTouchGame() -> Game {
        return Game(score: 0, gameTimeInSeconds: 7)
    }
    
    // MARK: - Intents
    
    func handleGame(screenWidth: CGFloat, screenHeight: CGFloat) {
        if game.isStarted && game.score < Constants.pointsToFinishTheGame {
            assignAPoint()
            position = randomPosition(screenWidth: screenWidth, screenHeight: screenHeight)
            
            if game.score == Constants.pointsToFinishTheGame {
            
                finishTime = Date.now
                timerIsDeactivated = true
                
                // To let the user see the score and the time
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                    self?.game.isStarted = false
                    if let finishTime = self?.finishTime, let startTime = self?.startTime {
                        
                        if abs(Int(finishTime.timeIntervalSince(startTime))) > Constants.secondsToWinTheGame {
                            self?.userStatus = .loser
                        } else {
                            self?.userStatus = .winner
                        }
                    }
                }
            }
        }
    }
    
    func startGame() {
        startTime = Date.now
        game.isStarted = true
        showStartButton = false
        timerIsDeactivated = false
        
    }
    
    func restartGame() {
        game.score = 0
        position = nil
        userStatus = nil
        finishTime = nil
        showStartButton = true
        game.isStarted = false
        timerIsDeactivated = true
    }
    
    // MARK: - Private methods
    
    private func assignAPoint() {
        if game.isStarted {
            game.score += 1
        }
    }
    
    private func randomPosition(screenWidth: CGFloat, screenHeight: CGFloat) -> CGPoint {
        
        let halfOfTheFigurePlusShadow = Constants.figureWidth + Constants.figureShadow
        
        let middleX = screenWidth/2
        let middleY = screenHeight/2
        
        let xPoint = CGFloat.random(in: -middleX...middleX)
        let yPoint = CGFloat.random(in: -middleY...middleY)
        
        let xPointWithRadius = xPoint > 0 ? xPoint - halfOfTheFigurePlusShadow : xPoint + halfOfTheFigurePlusShadow
        let yPointWithRadius = yPoint > 0 ? yPoint - halfOfTheFigurePlusShadow : yPoint + halfOfTheFigurePlusShadow
        
        return CGPoint(x: middleX + xPointWithRadius, y: middleY + yPointWithRadius)
    }
    
    // MARK: - User Defaults
    
    let userDefaultsKey = "touchGame"
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(game.isPlayedForTheFirstTime), forKey: userDefaultsKey)
        
        
    }
    
    private func restoreFromUserDefaults() -> Game? {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey) {
            if let isPlayedForTheFirstTime = try? JSONDecoder().decode(Bool.self, from: jsonData) {
                return Game(score: 0, gameTimeInSeconds: 7, isPalyedForTheFirstTime: isPlayedForTheFirstTime)
            }
        }
        return nil
    }
    
    // MARK: - Initialization
    init() {
        if let game = restoreFromUserDefaults() {
            self.game = game
        } else {
            game = Game(score: 0, gameTimeInSeconds: 7)
        }
    }
}
