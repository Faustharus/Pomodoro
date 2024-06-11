//
//  ClockTimerView.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 08/06/2024.
//

import SwiftUI

struct ClockTimerView: View {
    
    @State private var timer: Timer?
    
    @State private var isSettingNewTime: Bool = false
    @State private var workSecondsElapsed: Int = 1 * 60
    @State private var breakSecondsElapsed: Int = 1 * 60
    
    @State private var isStarted: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Work Time: \(scheduledWorkTime)")
                // TODO: Setting Work Time, Break Time and how many times without the animated circle by adding the informations through the same kind of code as Newsletter Project
                
                Button {
                    startTimer()
                } label: {
                    Text("Start")
                }
                .buttonStyle(.borderedProminent)
                
                Button(role: .destructive) {
                    stopTimer()
                } label: {
                    Text("Stop")
                }
                .buttonStyle(.borderedProminent)
            }
            .toolbar {
                Button {
                    self.isSettingNewTime.toggle()
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
            .sheet(isPresented: $isSettingNewTime) {
                AddCycleView()
            }
        }
    }
}

#Preview {
    ClockTimerView()
}

// MARK: Computed Properties & Functions
extension ClockTimerView {
    
    var scheduledWorkTime: String {
        let minutes = workSecondsElapsed / 60
        let seconds = workSecondsElapsed % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        isStarted = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if workSecondsElapsed > 0 {
                workSecondsElapsed -= 1
            } else {
                isStarted = false
            }
        })
    }
    
    func stopTimer() {
        isStarted = false
    }
    
}
