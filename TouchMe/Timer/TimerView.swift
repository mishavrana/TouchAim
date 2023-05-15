//
//  TimerView.swift
//  TouchMe
//
//  Created by Misha Vrana on 11.05.2023.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var timer: TimerViewModel = TimerViewModel()
    var isDiactivated: Bool
    var body: some View {
        Text("\(timer.time)")
            .onChange(of: isDiactivated) { newValue in
                if !newValue {
                    timer.startTimer(with: Date.now)
                } else {
                    timer.reset()
                }
            }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(isDiactivated: false)
    }
}
