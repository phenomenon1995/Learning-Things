//
//  ContentView.swift
//  BetterRest
//
//  Created by David Williams on 8/22/24.
//
import CoreML
import SwiftUI


struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    var idealSleepTime: Date {
        let sleepTime: Date
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch{
            //something went wrong!
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
            sleepTime = Date.now
        }
        
        return sleepTime
    }
    
    static var defaultWakeTime : Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                Section("Desired Amount of Sleep?"){
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12)
                }
                Section("Daily coffee intake"){
                    Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount){
                        ForEach(1..<21){
                            Text("\($0 - 1)")
                        }
                    }
                }
                Spacer()
                Text("You should go to bed at").textCase(.uppercase)
                Text("\(idealSleepTime.formatted(date: .omitted, time: .shortened))")
                    .fontWeight(.bold)
                    .font(.largeTitle)
            }
            
            
           
            
            .navigationTitle("Better Rest")
        }
        .padding()
        
    }
    func calculateBedtime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch{
            //something went wrong!
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
        }
        
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
