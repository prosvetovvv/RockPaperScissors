//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Vitaly Prosvetov on 24.02.2021.
//

import SwiftUI

enum Things: String {
    case rock = "🪨"
    case paper = "📜"
    case scissors = "✂️"
}

struct ContentView: View {
    private let things: [Things] = [.rock, .paper, .scissors]
    
    @State private var currentThing = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var showingGameOver = false
    @State private var rightsAnswers = 0
    @State private var amountRounds = 10
    @State private var currentRound = 1

    
    var gameMode: String {
        return shouldWin ? "Win" : "Lost"
    }
    
    var correctAnswer: Things {
        switch things[currentThing] {
        case .rock:
            return shouldWin ? .paper : .scissors
        case .paper:
            return shouldWin ? .scissors : .rock
        case .scissors:
            return shouldWin ? .rock : .paper
        }
    }
    
    var body: some View {
        VStack() {
            Text("Rock, Paper and Scissors")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Spacer()
            
            Text(things[currentThing].rawValue)
                .font(.system(size: 100))
            
            Spacer()
            
            GameModeText(text: gameMode)
                        
            HStack {
                ForEach(things, id: \.self) { thing in
                    Button(action: {
                        thingTapped(thing)
                    }) {
                        Text(thing.rawValue)
                            .font(.system(size: 40))
                            .padding()
                    }
                }
            }
            
            Spacer()
            
            Text("Round: \(currentRound) / \(amountRounds)")
                .padding(1)
            
            Text("Right answers: \(rightsAnswers)")
        }
        .alert(isPresented: $showingGameOver) {
            Alert(title: Text("Game over"), message: Text("Score: \(rightsAnswers) / \(amountRounds)"), dismissButton: .default(Text("New game?")) {
                self.newGame()
            })
        }
        
    }
    
    func thingTapped(_ thing: Things) {
        if thing == correctAnswer {
            rightsAnswers += 1
        }
        
        if currentRound == 10 {
            showingGameOver = true
        } else {
            newRound()
            currentRound += 1
        }
        
    }
    
    func newRound() {
        currentThing = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func newGame() {
        currentThing = Int.random(in: 0...2)
        shouldWin = Bool.random()
        currentRound = 0
        rightsAnswers = 0
    }
}

struct GameModeText: View {
    let text: String
    
    var body: some View {
        HStack {
            Text("Tab the movie for")
            Text(text)
                .foregroundColor(.red)
        }
        .font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

