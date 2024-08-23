//
//  ContentView.swift
//  WordScramble
//
//  Created by David Williams on 8/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords: Array<String> = [String]()
    @State private var rootWord: String = ""
    @State private var newWord: String = ""
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var showingError: Bool = false
    @State private var score: Int = 0

    var body: some View {
        NavigationStack{
            Text("SCORE: \(score)")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .fontWeight(.bold)
            List{
                Section{
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        
                }
                Section{
                    ForEach(usedWords, id:\.self){word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform:startGame)
            .alert(errorTitle, isPresented: $showingError){
                Button("OK"){}
            } message: {
                Text(errorMessage)
            }
            .toolbar(content: {
                Button("Start Over", action: startGame)
            })
            .padding()
        }
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be More Original")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "you can't spell that word from '\(rootWord)'")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not real", message: "You can't just make stuff up!")
            return
        }
        guard answer.count > 2  else {
            wordError(title: "Word too short", message: "You gotta try harder than that!")
            return
        }
        guard answer != rootWord  else {
            wordError(title: "Same as starting word", message: "You gotta try harder than that!")
            return
        }
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        score += usedWords.count * answer.count
        newWord = ""
    }
    func startGame(){
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    func isOriginal(word: String) -> Bool{
        return !usedWords.contains(word)
    }
    func isPossible(word: String) -> Bool{
        var tempWord = rootWord
        var possible = true
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                possible = false
            }
        }
        return possible
    }
    func isReal(word: String)-> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}
#Preview {
    ContentView()
}
