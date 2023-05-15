//
//  TimerViewModel.swift
//  TouchMe
//
//  Created by Misha Vrana on 08.05.2023.
//

import Foundation

class TimerViewModel: ObservableObject {
    var timer: Timer?
    @Published var time = 0
    
    // Timer logic runs on different thread to ensure that actions on UI do not interupt it's work
    func startTimer(with startTime: Date) {
        let timerQueue = DispatchQueue(label: "com.example.timer")
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            timerQueue.async {
                self.updateTimeLeft(startTime: startTime)
            }
        })
    }
    
    // Updating the UI element 'timeLeft' variable goes on main thread
    func updateTimeLeft(startTime: Date) {
        DispatchQueue.main.async { [weak self] in
            self?.time = abs(Int(startTime.timeIntervalSinceNow))
        }
    }
    
    func reset() {
        self.timer?.invalidate()
        self.timer = nil
        time = 0
    }
    
    static func createTimerViewModel() -> TimerViewModel {
        return TimerViewModel()
    }
}
