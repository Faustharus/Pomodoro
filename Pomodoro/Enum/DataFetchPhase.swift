//
//  DataFetchPhase.swift
//  Pomodoro
//
//  Created by Damien Chailloleau on 11/06/2024.
//

import Foundation

enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}
