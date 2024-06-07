//
//  AddCycleView.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 04/06/2024.
//

import SwiftData
import SwiftUI

struct AddCycleView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var defaultWorkSecondsLeft: Int = 25 * 60
    @State private var defaultBreakSecondsLeft: Int = 5 * 60
    @State private var defaultTotalTurn: Int = 2
    
    @State private var secondsValueWork: String = ""
    @State private var secondsValueBreak: String = ""
    @State private var totalTurn: String = ""
    
    let defaultValue: Int = 25 * 60
    let defaultValueBreak: Int = 5 * 60
    let defaultTurn: Int = 2
    
    @FocusState var isValueFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Work Time", text: $secondsValueWork)
                    .keyboardType(.numberPad)
                    .padding(.all, 10)
                    .textFieldStyle(.roundedBorder)
                    .focused($isValueFocused)
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
                    .focused($isValueFocused)
                    .onChange(of: secondsValueBreak) { oldValue, newValue in
                        if let minutes = Int(newValue) {
                            defaultBreakSecondsLeft = minutes * 60
                        } else {
                            defaultBreakSecondsLeft = defaultValueBreak
                        }
                    }
                
                TextField("Number of Turn", text: $totalTurn)
                    .keyboardType(.numberPad)
                    .padding(.all, 10)
                    .textFieldStyle(.roundedBorder)
                    .focused($isValueFocused)
                    .onChange(of: totalTurn) { oldValue, newValue in
                        if let newTotalTurn = Int(newValue) {
                            defaultTotalTurn = newTotalTurn
                        } else {
                            defaultTotalTurn = defaultTurn
                        }
                    }
            }
            .formStyle(.columns)
            .background(.red)
            .toolbar {
//                Button {
//                    dismiss()
//                } label: {
//                    Label("Done", systemImage: "xmark")
//                }
                
//                Button {
//                    let newTimer = ClockCycle(workTime: secondsValueWork, breakTime: secondsValueBreak, howManyTimes: totalTurn)
//                    modelContext.insert(newTimer)
//                    dismiss()
//                } label: {
//                    Label("Confirm", systemImage: "doc.badge.plus")
//                }
//                .disabled(true)
            }
        }
    }
}

#Preview {
    AddCycleView()
}
