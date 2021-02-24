//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Vitaly Prosvetov on 24.02.2021.
//

import SwiftUI

enum Movies: String {
    case rock = "🪨"
    case paper = "📜"
    case scissors = "✂️"
}

struct ContentView: View {
    private let movies: [Movies] = [.rock, .paper, .scissors]
    
    @State private var currentMovie = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var gameScore = 0
    
    var gameMode: String {
        return shouldWin ? "Win" : "Lost"
    }
    
    var correctAnswer: Movies {
        switch movies[currentMovie] {
        case .rock:
            return shouldWin ? .paper : .scissors
        case .paper:
            return shouldWin ? .scissors : .rock
        case .scissors:
            return shouldWin ? .rock : .paper
        }
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Rock, Paper and Scissors")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Text(movies[currentMovie].rawValue)
                .font(.system(size: 100))
            
            Spacer()
            
            Text("Tab the movie for \(gameMode)")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            
            HStack {
                ForEach(movies, id: \.self) { movie in
                    Button(action: {
                        //tapped
                    }) {
                        Text(movie.rawValue)
                            .font(.system(size: 40))
                            .padding()
                    }
                }
            }
            
            Spacer()
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: <#T##Text?#>, dismissButton: <#T##Alert.Button?#>)
        }
    }
    
    func movieTapped(_ movie: Movies) {
        if movie == correctAnswer {
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

