//
//  TestView.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 25/05/2024.
//

import SwiftData
import SwiftUI

@Observable
class Clocks {
    var clocks = [ClockItem]()
}

struct ClockItem: Identifiable {
    var id: String = UUID().uuidString
    var workLength: Int
    var breakLength: Int
}

struct TestView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var timer: Timer?
    @State private var secondsElapsed = 25 * 60
    @State private var isRunning = false
    
    @State private var clockCycle = Clocks()
    
//    @Query var cycles: [Cycle]
    
    @State private var workSecondsElapsed: Int = 0
    @State private var breaktimeSecondsElapsed: Int = 0
    
    private let totalTime = 25 * 60
    
//    private let workTime = Number of Minutes for work * 60
//    private let breaktime = Number of Minutes for break * 60
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(clockCycle.clocks, id: \.id) { item in
                    Text("\(item.workLength)")
                }
                Text("\(formattedTime)")
                    .font(.system(size: 72))
                    .padding()
                
                Section("Work Duration") {
                    TextField("Work Duration", value: $workSecondsElapsed, format: .number)
                }
                
                Section("Breaktime Duration") {
                    TextField("Breaktime Duration", value: $breaktimeSecondsElapsed, format: .number)
                }
                
//                Button(action: storeNewClock) {
//                    Text("Setting a New Clock")
//                        .font(.title)
//                        .padding()
//                        .background(workSecondsElapsed == 0 || breaktimeSecondsElapsed == 0 ? Color.gray : Color.green)
//                        .foregroundStyle(.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                }
//                .disabled(workSecondsElapsed == 0 || breaktimeSecondsElapsed == 0)
                
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
            .toolbar {
                Button("Add New Clock", systemImage: "plus") {
                    let newClock = ClockItem(workLength: workSecondsElapsed * 60, breakLength: breaktimeSecondsElapsed * 60)
                    clockCycle.clocks.append(newClock)
                }
            }
            .onDisappear(perform: stopTimer)
        }
    }
    
    private var formattedTime: String {
        var minutes: Int = 0
        var seconds: Int = 0
        
        for item in clockCycle.clocks {
            let minutesItem = item.workLength / 60
            let secondsItem = item.breakLength % 60
            
            minutes = minutesItem
            seconds = secondsItem
        }
        
        return String(format: "%02d:%02d", minutes, seconds)
//        let minutes = secondsElapsed / 60
//        let seconds = secondsElapsed % 60
//        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            if totalTime > secondsElapsed {
//                secondsElapsed -= 1
//            } else {
//                stopTimer()
//            }
//            if secondsElapsed < totalTime {
//                secondsElapsed += 1
//            } else {
//                stopTimer()
//            }
            if isRunning {
                var newValue = (formattedTime as NSString).integerValue
                newValue -= 1
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
    
//    private func storeNewClock() {
//        let newClock = Cycle(breakLength: workSecondsElapsed * 60, workLength: breaktimeSecondsElapsed * 60)
//        modelContext.insert(newClock)
//        dismiss()
//    }
}

#Preview {
    TestView()
}
