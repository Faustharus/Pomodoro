//
//  Cycle.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 23/05/2024.
//

import SwiftData
import SwiftUI

@Model
final class Cycle: Identifiable {
    var id: String = UUID().uuidString
    var breakLength: Int
    var workLength: Int
    var storedAt: Date
    
    init(id: String, breakLength: Int, workLength: Int, storedAt: Date) {
        self.id = id
        self.breakLength = breakLength
        self.workLength = workLength
        self.storedAt = storedAt
    }
    
}
