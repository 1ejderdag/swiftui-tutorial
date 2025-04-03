//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ejder Dağ on 27.03.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...3)
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var point = 0
    @State private var endOfGame = false
    
    @State private var games = 4
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom) // zstackte olduğu için altta kalacak.
                .ignoresSafeArea()
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                Spacer()
                
                Text("Score: \(point)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Spacer()
                        Text("Guess the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.white)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                    
                    ForEach(0..<4) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(flagName: countries[number].lowercased())
                        }
                    }
                    .alert(scoreTitle, isPresented: $showingScore) {
                        Button("Continue", action: askQuestion)
                    } message: {
                        Text("Your score is \(point)")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            }
            .padding()
        }
        .alert("The end", isPresented: $endOfGame) {
            Button("Play again", action: reset)
        } message: {
            Text("Your total score is \(point)")
        }
        
    }
}

struct FlagImage: View {
    var flagName: String
    var body: some View {
        Image(flagName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

extension ContentView {
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            point += 10
        } else {
            scoreTitle = "Wrong! That is the flag of \(countries[number])"
        }

        showingScore = true
        games -= 1
        
        if games <= 0 {
            endOfGame = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...3)
    }
    
    func reset() {
        point = 0
        games = 3
        countries.shuffle()
        correctAnswer = Int.random(in: 0...3)
    }
}

#Preview {
    ContentView()
}
