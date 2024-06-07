//
//  AnimatedTimeView.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 27/05/2024.
//

import SwiftUI

struct AnimatedTimeView: View {
    
    let model: AnimatedTimeViewItemModel
    
    @State private var completionAmount = 270.0
    @State private var isActivated: Bool = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {
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
                        .onReceive(timer) { _ in
                            if isActivated {
                                if completionAmount >= 359 {
                                    completionAmount = 0
                                    isActivated = false
                                } else {
                                    withAnimation(.linear(duration: 0.1)) {
                                        completionAmount += 1.0
                                    }
                                }
                            }
                        }
                    
                }
            }
            Text("\(completionAmount, specifier: "%g")")
            Button(isActivated ? "Stop" : "Start") {
                self.isActivated.toggle()
            }
        }
    }
}

#Preview {
    AnimatedTimeView(model: (completionAmount: 270.0, isActivated: false) )
}

typealias AnimatedTimeViewItemModel = (completionAmount: Double, isActivated: Bool)
