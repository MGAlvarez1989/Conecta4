//
//  Turn.swift
//  Conecta4
//
//  Created by Matias Alvarez on 3/1/25.
//

import SwiftUI

enum Turn: String {
    case red
    case yellow
    
    static var redWins = 0
    static var yellowWins = 0
    
    static func incrementWins(for turn: Turn) {
        switch turn {
        case .red: redWins += 1
        case .yellow: yellowWins += 1
        }
    }
    
    static func resetWins() {
        redWins = 0
        yellowWins = 0
    }
    
    static func currentWins() -> (red: Int, yellow: Int) {
        return (redWins, yellowWins)
    }
    
    var color: Color {
        switch self {
        case .red: return .red
        case .yellow: return .yellow
        }
    }
    
    mutating func toggle() {
        self = self == .red ? .yellow : .red
    }
}
