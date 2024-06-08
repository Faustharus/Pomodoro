//
//  ClockCycle.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 03/06/2024.
//

import SwiftData
import SwiftUI

@Model
final class ClockCycle {
    var completionAmount: Double
    var workTime: String
    var breakTime: String
    var howManyTimes: String
    
    init(completionAmount: Double, workTime: String, breakTime: String, howManyTimes: String) {
        self.completionAmount = completionAmount
        self.workTime = workTime
        self.breakTime = breakTime
        self.howManyTimes = howManyTimes
    }
}
