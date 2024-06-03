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
    @State private var defaultBreakSecondsLeft: Int = 1 * 60
    
    @State private var secondsValueWork: String = ""
    @State private var secondsValueBreak: String = ""
    
    let defaultValue: Int = 25 * 60
    let defaultValueBreak: Int = 5 * 60
    
    @State private var completionAmount: Double = 0.0
    @State private var isActivated: Bool = false
    let clock = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            TextField("Work Time", text: $secondsValueWork)
                .keyboardType(.numberPad)
                .padding(.all, 10)
                .textFieldStyle(.roundedBorder)
                .onChange(of: secondsValueWork) { oldValue, newValue in
                    if let minutes = Int(newValue) {
                        defaultWorkSecondsLeft = minutes * 60
                    } else {
                        defaultWorkSecondsLeft = defaultValue
                    }
                }
            
            TextField("Break Time", text: $secondsValueBreak)
                .keyboardType(.numberPad)
                .padding(.all, 10)
                .textFieldStyle(.roundedBorder)
                .onChange(of: secondsValueBreak) { oldValue, newValue in
                    if let minutes = Int(newValue) {
                        defaultBreakSecondsLeft = minutes * 60
                    } else {
                        defaultBreakSecondsLeft = defaultValueBreak
                    }
                }
            
            ZStack {
                if defaultWorkSecondsLeft == 0 {
                    Text("Break Time : \(dynamicBreakClock)")
                } else {
                    Text("Work Time : \(dynamicWorkClock)")
                }
                Circle()
                    .stroke(.black.opacity(0.2), lineWidth: 35)
                    .padding(.all, 30)
                
                Circle()
                    .trim(from: 0, to: CGFloat(completionAmount / 360.0))
                    .stroke(.orange.opacity(0.9), lineWidth: 35)
                    .padding(.all, 30)
                    .rotationEffect(.degrees(-90))
                
                VStack {
                    Circle()
                        .fill(.red)
                        .frame(width: 30)
                        .offset(x: 0, y: -167)
                        .rotationEffect(.degrees(completionAmount))
                        .onReceive(clock) { _ in
                            if isActivated {
                                if completionAmount >= 359 {
                                    completionAmount = 0
                                } else {
                                    if defaultWorkSecondsLeft == 0 {
                                        withAnimation(.linear(duration: 1.0)) {
                                            completionAmount += 360.0 / ((Double(secondsValueBreak) ?? 0.0) * 60)
                                        }
                                    } else {
                                        withAnimation(.linear(duration: 1.0)) {
                                            completionAmount += 360.0 / ((Double(secondsValueWork) ?? 0.0) * 60)
                                        }
                                    }
                                }
                                if defaultWorkSecondsLeft == 0 && defaultBreakSecondsLeft == 0 {
                                    self.isActivated = false
                                }
                            }
                        }
                }
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
        isActivated = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if defaultWorkSecondsLeft > 0 {
                defaultWorkSecondsLeft -= 1
            } else if defaultBreakSecondsLeft > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    defaultBreakSecondsLeft -= 1
                }
            } else {
                stopClock()
            }
        })
    }
    
    func stopClock() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        isActivated = false
        isReseting = true
    }
    
    func resetClock() {
        timer?.invalidate()
        timer = nil
        completionAmount = 0.0
        if let minutes = Int(secondsValueWork) {
            defaultWorkSecondsLeft = minutes * 60
        } else {
            defaultWorkSecondsLeft = defaultValue
        }
        if let minutes = Int(secondsValueBreak) {
            defaultBreakSecondsLeft = minutes * 60
        } else {
            defaultBreakSecondsLeft = defaultValueBreak
        }
        isReseting = false
        isActivated = false
    }
    
}
