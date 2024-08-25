//
//  ContentView.swift
//  EdutainmentChallenge
//
//  Created by David Williams on 8/23/24.
//

import SwiftUI

struct SettingsView: View{
    @State private var difficulty: Int = 7
    @State private var numQuestions: Int = 5
    let possibleNumberOfQuestions: Array<Int> = [5,10,15]
    var startGameFunction: (Int, Int) -> Void
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Which Multiplication Tables Do You Want To Practice?"){
                    Stepper("Up To  \(difficulty) x \(difficulty)", value: $difficulty, in: 2...12)
                }
                Section("How Many Questions Do You Want To Practice?"){
                    Picker("\(numQuestions) questions", selection: $numQuestions){
                        ForEach(possibleNumberOfQuestions, id: \.self){
                            Text($0, format: .number)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Setup Game")
            .toolbar{
                Button("Play Game"){
                    startGameFunction(difficulty, numQuestions)
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var currentQuestion: Int = 1
    @State private var difficulty: Int = 2
    @State private var gameStarted: Bool = false
    @State private var numQuestions: Int = 5
    @State private var operand1: Int = 0
    @State private var operand2: Int = 0
    @State private var scaleAmount: Double = 1.0
    @State private var showingResult: Bool = false
    @State private var showingResultTitle: String = ""
    @State private var showingResultMessage: String = ""
    @State private var tapped: Int = 0
    @State private var userAnswer: Int = 0
    @State private var userScore: Int = 0
    private var correctAnswer: Int {
        return operand1 * operand2
    }
    @State private var possibleAnswers: Array<Int> = []
    
    var body: some View {
        NavigationStack{
            if gameStarted{
                VStack {
                    Text("Score: \(userScore)/\(numQuestions) | Question \(currentQuestion)/\(numQuestions)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.title3)
                    Spacer()
                    
                    Text("What is \(operand1) x \(operand2)")
                        .font(.title)
                        .fontWeight(.bold)
                    VStack{
                        ForEach(possibleAnswers, id: \.self){ answer in
                            Button{
                                userAnswer = answer
                                checkAnswer()
                                showingResult = true
                                withAnimation{
                                    scaleAmount = 0.5
                                }
                            } label: {
                                Text("\(answer)")
                                    .fontWeight(.bold)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .background(showingResult ? (correctAnswer == answer ? .green : .red) : .blue)                            .clipShape(.rect(cornerRadius: 10))
                            .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                .alert(showingResultTitle, isPresented: $showingResult){
                    Button(currentQuestion != numQuestions ? "Next Question" : "New Game"){
                        if currentQuestion == numQuestions{
                            gameStarted = false
                        } else {
                            currentQuestion += 1
                            nextQuestion()
                            scaleAmount = 1
                        }
                        
                    }
                } message: {
                    Text(showingResultMessage)
                }
                .padding()
                .navigationTitle("Practice x Tables")
                
                .toolbar{
                    Button("Settings"){
                        gameStarted = false
                    }
                }
                
            } else {
                SettingsView(startGameFunction: startGame)
            }
        }
    }
    
    func startGame(diff: Int, num: Int){
        difficulty = diff
        numQuestions = num
        currentQuestion = 1
        operand1 = Int.random(in:1...difficulty)
        operand2 = Int.random(in:1...difficulty)
        userScore = 0
        nextQuestion()
        gameStarted = true
    }
    
    func checkAnswer(){
        guard currentQuestion < numQuestions else {
            showingResultTitle = "Game Over"
            showingResultMessage = "You Got \(userScore) out of \(numQuestions) questions correct!"
            return
        }
        if userAnswer == (correctAnswer){
            userScore += 1
            showingResultTitle = "Correct"
            showingResultMessage = "So Proud of You!"
        } else {
            showingResultTitle = "Incorrect"
            showingResultMessage = "The answer is \(operand1 * operand2)"
        }
    }
    func nextQuestion(){
        operand1 = Int.random(in: 2...difficulty)
        operand2 = Int.random(in: 2...difficulty)
        
        possibleAnswers = []
        possibleAnswers.append(correctAnswer)
        for _ in 0..<3{
            var randomAnswer: Int = 0
            while true {
                randomAnswer = (Int.random(in: 1...15) * Int.random(in: 1...15))
                if !possibleAnswers.contains(randomAnswer){break}
            }
            possibleAnswers.append(randomAnswer)
        }

    }
    
}

#Preview {
    ContentView()
}
