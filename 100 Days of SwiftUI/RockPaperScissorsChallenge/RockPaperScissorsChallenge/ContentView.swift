//
//  ContentView.swift
//  RockPaperScissorsChallenge
//
//  Created by David Williams on 8/22/24.
//

import SwiftUI

struct ContentView: View {
    let maxRounds: Int = 3
    let moves: Array<String> = ["✊", "🤚", "✌️"]
    @State private var currentRound: Int = 0
    @State private var roundsWon: Int = 0
    @State private var computersChoice: String = "✊"
    @State private var shouldWin: Bool = Bool.random()
    @State private var gameOver: Bool = false
    var body: some View {
        
        
        ZStack {
            LinearGradient(stops: [
                .init(color: .black, location: 0.7),
                .init(color:.yellow, location: 1.0)
            ], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack (spacing: 30){
                Text("Rock Paper Scissors")
                Spacer()
                HStack {
                    Text("Computer Played")
                    Text(computersChoice)
                }
                HStack{
                    Text("Try To \(shouldWin ? "Win": "Lose")")
                        .font(.largeTitle)
                    
                }
                    .foregroundStyle(.yellow)
                Spacer()
                HStack {
                    ForEach(moves, id: \.self){move in
                        Button{
                            play(move)
                        } label: {
                            Text("\(move)")
                                .font(.system(size: 100))
                        }
                    }
                }
                Spacer()
                Text("Score: \(roundsWon) / \(maxRounds)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
            }
            .frame(maxWidth:.infinity, maxHeight: .infinity)
            .font(.title)
            .foregroundStyle(.yellow)
            .alert("Game Over", isPresented: $gameOver) {
                
                Button("Restart Game"){
                    currentRound = 1
                    roundsWon = 0
                }
            } message: {
                Text("You Scored \(roundsWon) points")
                    .fontWeight(.bold)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
        }
    }
    func play(_ move:String) -> Void {
        var won:Bool = false
        switch computersChoice {
        case "✊":
            if move == "🤚" {won = true}
        case "🤚":
            if move == "✌️" {won = true}
        case "✌️":
            if move == "✊" {won = true}
        default:
            won  = false
        }
        if (won && shouldWin) || (!won && !shouldWin) {
            roundsWon += 1
        }
        
        if currentRound == maxRounds {gameOver = true} else {currentRound += 1}
        computersChoice = moves[Int.random(in: 0...2)]
        shouldWin = Bool.random()

    }
}

#Preview {
    ContentView()
}
