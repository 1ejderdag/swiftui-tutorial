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
    @State private var animationAmount = 0.0
    @State private var scaleAmount = 1.0
    @State private var opacityAmount = 1.0
    
    
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
                            withAnimation {
                                flagTapped(number)
                                if number == correctAnswer {
                                    animationAmount += 360
                                }
                                opacityAmount = 0.25
                                scaleAmount = 0.8
                            }
                            
                        } label: {
                            FlagImage(flagName: countries[number].lowercased())
                                .rotation3DEffect(.degrees(number == correctAnswer ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(number != correctAnswer ? opacityAmount : 1)
                                .scaleEffect(number != correctAnswer ? scaleAmount : 1)
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
        // reset animations
        scaleAmount = 1.0
        animationAmount = 0.0
        opacityAmount = 1.0
    }
    
    func reset() {
        point = 0
        games = 3
        countries.shuffle()
        correctAnswer = Int.random(in: 0...3)
        // reset animations
        opacityAmount = 1.0
        scaleAmount = 1.0
        animationAmount = 0.0
    }
}

#Preview {
    ContentView()
}



/*
import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...3)
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var point = 0
    @State private var endOfGame = false
    @State private var userChoice = -1
    
    @State private var games = 4
    @State private var animationAmount = 0.0
    @State private var opacityAmount = 1.0
    @State private var scaleAmount = 1.0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
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
                            withAnimation {
                                flagTapped(number)
                                userChoice = number
                                if number == correctAnswer {
                                    animationAmount += 360
                                }
                                opacityAmount = 0.25
                                scaleAmount = 0.8
                            }
                        } label: {
                            FlagImage(flagName: countries[number].lowercased())
                                .rotation3DEffect(
                                    .degrees(number == userChoice ? animationAmount : 0),
                                    axis: (x: 0, y: 1, z: 0))
                                .opacity(number != userChoice ? opacityAmount : 1)
                                .scaleEffect(number != userChoice ? scaleAmount : 1)
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
        // Reset animation states
        userChoice = -1
        opacityAmount = 1.0
        scaleAmount = 1.0
    }
    
    func reset() {
        point = 0
        games = 3
        countries.shuffle()
        correctAnswer = Int.random(in: 0...3)
        // Reset animation states
        userChoice = -1
        opacityAmount = 1.0
        scaleAmount = 1.0
        animationAmount = 0.0
    }
}

#Preview {
    ContentView()
}*/
