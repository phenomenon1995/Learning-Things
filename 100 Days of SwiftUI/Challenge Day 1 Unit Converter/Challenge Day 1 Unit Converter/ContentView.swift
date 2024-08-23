//
//  ContentView.swift
//  Challenge Day 1 Unit Converter
//
//  Created by David Williams on 8/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var startingValue: Double = 0.0
    @State private var startingUnit: String = "Seconds"
    @State private var endingUnit: String = "Seconds"
    
    private let units: Array<String> = ["Seconds", "Minutes", "Hours", "Days"]
    private var result: Double {
        var conversionResult: Double = 0
        switch startingUnit {
        case "Seconds":
            switch endingUnit{
            case "Seconds":
                conversionResult = startingValue
                break
            case "Minutes":
                conversionResult = startingValue / 60
                break
            case "Hours":
                conversionResult = startingValue / 3600
                break
            case "Days":
                conversionResult = startingValue / 86400
                break
            default:
                conversionResult = 0
            }
            break
        case "Minutes":
            switch endingUnit{
            case "Seconds":
                conversionResult = startingValue * 60
                break
            case "Minutes":
                conversionResult = startingValue
                break
            case "Hours":
                conversionResult = startingValue / 60
                break
            case "Days":
                conversionResult = startingValue / 1440
                break
            default:
                conversionResult = 0
            }
            break
            
        case "Hours":
            switch endingUnit{
            case "Seconds":
                conversionResult = startingValue * 3600
                break
            case "Minutes":
                conversionResult = startingValue * 60
                break
            case "Hours":
                conversionResult = startingValue
                break
            case "Days":
                conversionResult = startingValue / 24
                break
            default:
                conversionResult = 0
            }
            break
            
        case "Days":
            switch endingUnit{
            case "Seconds":
                conversionResult = startingValue * 86400
                break
            case "Minutes":
                conversionResult = startingValue * 1440
                break
            case "Hours":
                conversionResult = startingValue * 24
                break
            case "Days":
                conversionResult = startingValue
                break
            default:
                conversionResult = 0
            }
            break
            
        default:
            conversionResult = 0
        }
        
        return conversionResult

    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Convert From"){
                    TextField("Value to convert: ", value:$startingValue , format: .number)
                    Picker("Starting Unit", selection: $startingUnit){
                        ForEach(units, id: \.self){
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Convert To"){
                    Picker("Ending Unit", selection: $endingUnit){
                        ForEach(units, id:\.self){
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Result"){
                    Text("\(startingValue, format: .number) \(startingUnit) is equal to \(result, format: .number) \(endingUnit)")
                }
                
                
            }
            .navigationTitle("Time Converter")
        }
    }
}

#Preview {
    ContentView()
}
