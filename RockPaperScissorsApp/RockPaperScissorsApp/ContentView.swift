//
//  ContentView.swift
//  RockPaperScissorsApp
//
//  Created by Ejder Dağ on 3.04.2025.
//

import SwiftUI

struct ContentView: View {
    
    let moves = ["✊", "✋", "✌️"]
    let winningMoves = [ "✋", "✌️", "✊"]
    
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var questionCount = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .pink], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("Brain Trainer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(colors: [.yellow, .red, .yellow, .red, .yellow, .red], startPoint: .leading, endPoint: .trailing))
                
                Spacer()
                
                VStack(spacing: 40) {
                    
                    Text("Score: \(score)")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundStyle(.white)
                    
                    Text("App Choice: ")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text(moves[appChoice])
                        .font(.system(size: 100))
                    
                    Text(shouldWin ? "WIN" : "LOSE")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(shouldWin ? .green : .red)
                    
                    HStack(spacing: 20) {
                        ForEach(0..<3, id: \.self) { index in
                            Button {
                                play(move: index)
                            } label: {
                                Text(moves[index])
                                    .font(.system(size: 70))
                                    .padding()
                                    .background(Color.white.opacity(0.35))
                                    .clipShape(Circle())
                            }
                        }
                    }
                    Spacer()
                    Text("Question: \(questionCount)/10")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
        }
        .alert("The end", isPresented: $gameOver) {
            Button("Play again", action: reset)
        } message: {
            Text("Your total score is \(score)/\(questionCount)")
        }
    }
    
    func play(move: Int) {
        
        let winningMove = winningMoves[appChoice]
        let playerWins: Bool
        
        let playerMove = moves[move]
        
        if shouldWin {
            playerWins = winningMove == playerMove
        } else {
            playerWins = winningMove != playerMove && playerMove != moves[appChoice]
        }
        
        if playerWins {
            score += 1
        } else {
            score -= 1
        }
        
        questionCount += 1
        
        if questionCount == 10 {
            gameOver = true
        } else {
            nextQuestion()
        }
    }
    
    func nextQuestion() {
        appChoice = Int.random(in: 1...2)
        shouldWin = Bool.random()
    }
    
    func reset() {
        score = 0
        questionCount = 0
        gameOver = false
        nextQuestion()
    }
}


#Preview {
    ContentView()
}
