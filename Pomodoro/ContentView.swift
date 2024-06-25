//
//  ContentView.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 19/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    
    let countdown = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .foregroundStyle(.blue)
            Text("Hello, world !")
            
            Spacer().frame(height: 20)
            
            Text("Work : \(workSeconds)")
                .font(.title)
            
            Text("Break : \(breakSeconds)")
                .font(.title)
            
            Button("Start") {
                viewModel.startCountdown()
            }
            .buttonStyle(.bordered)
            .disabled(viewModel.isCountingDown)
            
            Button("Pause") {
                viewModel.stopCountdown()
            }
            .buttonStyle(.borderedProminent)
            .disabled(!viewModel.isCountingDown)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

// MARK: Computed Properties & Functions
extension ContentView {
    
    var workSeconds: String {
        let minutes = viewModel.secondsWorkElapsed / 60
        let seconds = viewModel.secondsWorkElapsed % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var breakSeconds: String {
        let minutes = viewModel.secondsBreakElapsed / 60
        let seconds = viewModel.secondsBreakElapsed % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
}
