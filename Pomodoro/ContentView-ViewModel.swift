//
//  ContentView-ViewModel.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 25/06/2024.
//

import Foundation

extension ContentView {
    @Observable
    class ViewModel {
        var timer: Timer?
        
        var secondsWorkElapsed: Int = 1 * 60
        var secondsBreakElapsed: Int = 1 * 60
        
        var isCountingDown: Bool = false
        
        var defaultSecondsWork: Int = 2 * 60
        var defaultSecondsBreak: Int = 1 * 60
        
        func startCountdown() {
            isCountingDown = true
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
                if self.secondsWorkElapsed > 0 {
                    self.secondsWorkElapsed -= 1
                } else if self.secondsBreakElapsed > 0 {
                    self.secondsBreakElapsed -= 1
                } else {
                    self.isCountingDown = false
                }
            })
        }
        
        func stopCountdown() {
            self.timer?.invalidate()
            self.timer = nil
            self.isCountingDown = false
        }
        
    }
}
