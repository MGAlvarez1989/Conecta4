//
//  ContentView.swift
//  Conecta4
//
//  Created by Matias Alvarez on 2/1/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            counter
                .frame(maxWidth: .infinity)
                .padding()
            playerTurn
            Spacer()
            board
            Spacer()
            buttons
        }
        .alert("We have a winner!!", isPresented: $viewModel.showWinner) {
            alertView
        } message: {
            Text("\(viewModel.turn.rawValue.capitalized) player won!")
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    private var counter: some View {
        VStack {
            Text("Games Won")
                .font(.headline)
            HStack {
                Text("Red: \(Turn.redWins)")
                Text("Yellow : \(Turn.yellowWins)")
            }
        }
    }
    
    private var playerTurn: some View {
        Text("\(viewModel.turn.rawValue.capitalized) player turn")
            .font(.largeTitle)
            .frame(maxWidth: .infinity)
    }
    
    private var board: some View {
        HStack {
            ForEach(Array(viewModel.board.enumerated()), id: \.offset) { columIndex, colum in
                VStack {
                    ForEach(Array(colum.enumerated()), id: \.offset) { rowIndex, _ in
                        Circle()
                            .fill(viewModel.board[columIndex][rowIndex])
                            .overlay{
                                Circle()
                                    .stroke(Color.primary, lineWidth: 2)
                            }
                            .frame(maxWidth: 50, maxHeight: 50)
                            .onTapGesture {
                                withAnimation(.linear(duration: 0.2)) {
                                    if let lastClear = viewModel.board[columIndex].lastIndex(where: { $0 == .clear }) {
                                        viewModel.board[columIndex][lastClear] = viewModel.turn.color
                                        viewModel.checkForWinner()
                                        if !viewModel.showWinner {
                                            viewModel.turn.toggle()
                                        }
                                    }
                                }
                            }
                    }
                }
            }
        }
        .padding()
    }
    
    private var buttons: some View {
        VStack {
            Group {
                Button(action: {
                    viewModel.reset()
                }, label: {
                    Text("Reset Match")
                        .frame(maxWidth: .infinity, maxHeight: 32)
                })
                
                Button(action: {
                    viewModel.finishGame()
                }, label: {
                    Text("Reset Wins")
                        .frame(maxWidth: .infinity, maxHeight: 32)
                })
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 16)
            .padding(.top, 30)
        }
    }
    
    private var alertView: some View {
        HStack {
            Button(role: .cancel) {
                viewModel.reset()
            } label: {
                Text("Play again")
            }
            
            Button(role: .destructive) {
                viewModel.finishGame()
            } label: {
                Text("Stop playing")
            }
        }
    }
}
