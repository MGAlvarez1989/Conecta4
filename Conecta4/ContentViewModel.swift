//
//  ContentViewModel.swift
//  Conecta4
//
//  Created by Matias Alvarez on 3/1/25.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var turn: Turn = .red
    @Published var board: [[Color]] = Array(repeating: Array(repeating: .clear, count: 6), count: 7)
    @Published var showWinner: Bool = false
    
    var counter: Int = 0
    
    func reset() {
        board = board.map{ $0.map{ _ in .clear } }
        counter = 0
    }
    
    func finishGame() {
        reset()
        Turn.resetWins()
    }
    
    func checkForWinner() {
        counter += 1
        if counter > 6 {
            print("Start testing")
            for (colum, array) in board.enumerated() {
                for (row, _ ) in array.enumerated() {
                    if checkDirection(col: colum, row: row, dRow: 0, dCol: 1) || checkDirection(col: colum, row: row, dRow: 1, dCol: 0) ||
                        checkDirection(col: colum, row: row, dRow: 1, dCol: 1) || checkDirection(col: colum, row: row, dRow: 1, dCol: -1) {
                        Turn.incrementWins(for: turn)
                        showWinner = true
                    }
                }
            }
        }
    }
    
    private func checkDirection(col: Int, row: Int, dRow: Int, dCol: Int) -> Bool {
        let color = board[col][row]
        var count = 1
        for step in 1..<4 {
            let newCol = col + step * dCol
            let newRow = row + step * dRow
            if newRow < 0 || newCol < 0 || newCol >= board.count || newRow >= board[newCol].count || color == .clear {
                break
            }
            if board[newCol][newRow] != color {
                break
            }
            count += 1
        }
        return count == 4
    }
}
