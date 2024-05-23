//
//  ContentView.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 19/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var timer: Timer?
    @State private var secondsElapsed = 0
    @State private var isRunning = false
    
    private let totalTime = 25 * 60
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(formattedTime)")
                    .font(.system(size: 72))
                    .padding()
                
                Button(action: startTimer) {
                    Text(isRunning ? "Running..." : "Start Timer")
                        .font(.title)
                        .padding()
                        .background(isRunning ? Color.gray : Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .disabled(isRunning)
                
                Button(role: .destructive, action: stopTimer) {
                    Text("Stop")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .navigationTitle("Pomodoro")
            .onDisappear(perform: stopTimer)
        }
    }
    
    private var formattedTime: String {
        let minutes = secondsElapsed / 60
        let seconds = secondsElapsed % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if secondsElapsed < totalTime {
                secondsElapsed += 1
            } else {
                stopTimer()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
}

#Preview {
    ContentView()
}
