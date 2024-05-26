//
//  NewClockView.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 25/05/2024.
//

import SwiftData
import SwiftUI

struct NewClockView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var workSecondsElapsed: Int = 0
    @State private var breaktimeSecondsElapsed: Int = 0
    
    var body: some View {
        List {
            Section("Work Time Duration") {
                TextField("Work Time Duration", value: $workSecondsElapsed, format: .number)
            }
               
            Section("Bk Time Duration") {
                TextField("Break Time Duration", value: $breaktimeSecondsElapsed, format: .number)
            }
            
            Button(action: newClock) {
                Text("Confirm")
            }
            .disabled(workSecondsElapsed == 0 || breaktimeSecondsElapsed == 0)
        }
    }
}

#Preview {
    NewClockView()
}

extension NewClockView {
    
    func newClock() {
        let newClock = Cycle(breakLength: breaktimeSecondsElapsed * 60, workLength: workSecondsElapsed * 60)
        modelContext.insert(newClock)
        dismiss()
    }
    
}
