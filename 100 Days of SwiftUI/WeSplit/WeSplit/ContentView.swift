//
//  ContentView.swift
//  WeSplit
//
//  Created by David Williams on 8/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages: Array<Int> = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue: Double = checkAmount / 100 * tipSelection
        let grandTotal:Double = checkAmount + tipValue
        let amountPerPerson: Double = grandTotal / peopleCount
        return amountPerPerson
    }
    var grandTotal: Double {
        return totalPerPerson * Double(numberOfPeople + 2)
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code:Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                        
                    }
                }
                Section("How Much Do You Want To Tip?") {
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text("\($0, format: .percent)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Amount Per Person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Total"){
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountIsFocused {
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
