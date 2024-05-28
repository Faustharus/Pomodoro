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
    @State private var defaultWorkSecondsLeft: Int = 25 * 60
    @State private var defaultBreakSecondsLeft: Int = 5 * 60
    
    @State private var testValueWork: String = ""
    @State private var testValueBreak: String = ""
    
    let defaultValue: Int = 25 * 60
    let defaultValueBreak: Int = 5 * 60
    
    var body: some View {
        VStack {
            Text("Hello, World !")
            
            TextField("Work Time", text: $testValueWork)
                .keyboardType(.numberPad)
                .padding()
                .textFieldStyle(.roundedBorder)
                .onChange(of: testValueWork) { oldValue, newValue in
                    if let minutes = Int(newValue) {
                        defaultWorkSecondsLeft = minutes * 60
                    } else {
                        defaultWorkSecondsLeft = defaultValue
                    }
                }
            
            TextField("Break Time", text: $testValueBreak)
                .keyboardType(.numberPad)
                .padding()
                .textFieldStyle(.roundedBorder)
                .onChange(of: testValueBreak) { oldValue, newValue in
                    if let minutes = Int(newValue) {
                        defaultBreakSecondsLeft = minutes * 60
                    } else {
                        defaultBreakSecondsLeft = 5 * 60
                    }
                }
            
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
        if let minutes = Int(testValueWork) {
            defaultWorkSecondsLeft = minutes * 60
        } else {
            defaultWorkSecondsLeft = defaultValue
        }
        if let minutes = Int(testValueBreak) {
            defaultBreakSecondsLeft = minutes * 60
        } else {
            defaultBreakSecondsLeft = defaultValueBreak
        }
        isReseting = false
    }
    
}
