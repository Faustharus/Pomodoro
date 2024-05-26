//
//  ContentView.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 19/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var timer: Timer?
    @State private var isRunning: Bool = false
    @State private var isReseting: Bool = false
    @State private var defaultWorkSecondsLeft: Int = 1 * 60
    @State private var defaultBreakSecondsLeft: Int = 1 * 60
    
    let defaultValue: Int = 25 * 60
    
    var body: some View {
        VStack {
            Text("Hello, World !")
            
            if defaultWorkSecondsLeft == 0 {
                Text("Break Time : \(dynamicBreakClock)")
            } else {
                Text("Work Time : \(dynamicWorkClock)")
            }
            
            Button(isReseting && !isRunning ? "Resume" : "Start") {
                startClock()
            }
            .buttonStyle(.bordered)
            
            Button(isReseting ? "Reset" : "Stop", role: .destructive) {
                if isReseting {
                    resetClock()
                } else {
                    stopClock()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentView()
}

// MARK: Computed Properties & Functions
extension ContentView {
    
    var dynamicWorkClock: String {
        let minutes = defaultWorkSecondsLeft / 60
        let seconds = defaultWorkSecondsLeft % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var dynamicBreakClock: String {
        let minutes = defaultBreakSecondsLeft / 60
        let seconds = defaultBreakSecondsLeft % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startClock() {
        isRunning = true
        isReseting = false
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if defaultWorkSecondsLeft > 0 {
                defaultWorkSecondsLeft -= 1
            } else if defaultBreakSecondsLeft > 0 {
                defaultBreakSecondsLeft -= 1
            } else {
                stopClock()
            }
        })
    }
    
    func stopClock() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        isReseting = true
    }
    
    func resetClock() {
        timer?.invalidate()
        timer = nil
        defaultWorkSecondsLeft = 1 * 60
        defaultBreakSecondsLeft = 1 * 60
        isReseting = false
    }
    
}
