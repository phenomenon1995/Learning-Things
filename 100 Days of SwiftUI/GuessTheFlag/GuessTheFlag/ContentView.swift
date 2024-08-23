//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by David Williams on 8/21/24.
//

import SwiftUI

struct FlagView: View {
    var country: String
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    
    @State private var countries: Array<String> = [
    "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    @State private var selectedAnswer = 0
    @State private var currentQuestion = 1
    private let maxQuestions = 8
    @State private var showingScore: Bool = false
    @State private var gameOver: Bool = false
    @State private var scoreTitle: String = ""
    @State private var userScore: Int = 0
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: .black, location: 0.3),
                .init(color: .yellow, location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.yellow)
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the Flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries [correctAnswer])
                            .foregroundStyle(.black)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        } label: {
                           FlagView(country: countries[number])
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text ("Score: \(userScore) / \(maxQuestions)")
                    .foregroundStyle(.black)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert (scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            switch scoreTitle {
            case "Correct":
                Text("Great Job!")
            case "Incorrect":
                Text("That's \(countries[selectedAnswer]) you silly goose!")
            default:
                Text("On to the next...")
            }
        }
        .alert("Game Over", isPresented: $gameOver){
            Button("Restart"){
                userScore = 0
                currentQuestion = 0
                askQuestion()
            }
        } message: {
            Text("You got \(userScore) correct.")
            
        }
    }
    
    func flagTapped(_ number: Int) {
        showingScore = true
        selectedAnswer = number
        if selectedAnswer == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Incorrect"
        }
        
    }
    func askQuestion(){
        guard currentQuestion != maxQuestions else {
            gameOver = true
            return
        }
        
        if currentQuestion < maxQuestions {
            currentQuestion += 1
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
}

#Preview {
    ContentView()
}
