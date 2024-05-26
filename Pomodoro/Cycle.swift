//
//  Cycle.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 23/05/2024.
//

import SwiftData
import SwiftUI

@Model
final class Cycle {
    var id: String = UUID().uuidString
    var breakLength: Int
    var workLength: Int
    
    init(id: String = UUID().uuidString, breakLength: Int, workLength: Int) {
        self.id = id
        self.breakLength = breakLength
        self.workLength = workLength
    }
    
}
