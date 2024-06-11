//
//  ClockTimer.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 08/06/2024.
//

import Foundation

struct ClockTimer: Identifiable, Codable, Equatable, Hashable {
    var id: String = UUID().uuidString
    var secondsOfWorkScheduled: String
    var secondOfBreakScheduled: String
    var numberOfRuns: String
}
