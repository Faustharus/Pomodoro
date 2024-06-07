//
//  ClockCycleScreen.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 07/06/2024.
//

import Observation
import SwiftUI

@Observable
final class ClockCycleScreen {
    var tabIndex: Int = 0
    
    @ObservationIgnored
    var onBoardingModels: [AnimatedTimeViewItemModel] = [
        (completionAmount: 180, isActivated: false),
        (completionAmount: 90, isActivated: false),
        (completionAmount: 270, isActivated: false)
    ]
    
//    @ObservationIgnored
    func shouldShowButton() -> Bool {
        onBoardingModels.count - 1 == tabIndex
    }
}
