//
//  ClockPagesView.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 07/06/2024.
//

import Observation
import SwiftUI

struct ClockPagesView: View {
    @Bindable private var viewModel = ClockCycleScreen()
    
    var body: some View {
        ZStack {
            TabView(selection: $viewModel.tabIndex) {
                ForEach(0 ..< viewModel.onBoardingModels.count, id: \.self) { item in
                    AnimatedTimeView(model: viewModel.onBoardingModels[item]).tag(item)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                //TODO: - Custom PageControl will be there
                CustomPageControl(totalIndex: viewModel.onBoardingModels.count, selectedIndex: viewModel.tabIndex).animation(.spring(), value: UUID())
                    .padding(.horizontal).animation(.easeInOut, value: UUID())
                
            }
            .padding(.bottom, 100)
            .animation(.easeInOut, value: UUID())
        }
    }
}

#Preview {
    ClockPagesView()
}
