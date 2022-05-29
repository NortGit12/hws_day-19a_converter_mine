//
//  ContentView.swift
//  Conversions
//
//  Created by Jeff Norton on 5/13/22.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var fromTempIsFocused: Bool
    
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    @State private var selectedFromUnitType = "Fahrenheit"
    @State private var fromTemp: Double = 0.0
    var fromTempInFahrenheit: Double {
        var fahrenheitTemp = 0.0
        if selectedFromUnitType == "Celsius" {
            fahrenheitTemp = ((fromTemp * 9) / 5) + 32
        } else if selectedFromUnitType == "Kelvin" {
            fahrenheitTemp = (((fromTemp - 273.15) * 9) / 5) + 32
        } else {
            fahrenheitTemp = fromTemp
        }
        
        return fahrenheitTemp
    }
    @State private var selectedToUnitType = "Celsius"
    var toTemp: Double {
        var toTemp = 0.0
        if selectedToUnitType == "Celsius" {
            toTemp = ((fromTempInFahrenheit - 32) * 5) / 9
        } else if selectedToUnitType == "Kelvin" {
            toTemp = (((fromTempInFahrenheit - 32) * 5) / 9) + 273.15
        } else {
            toTemp = fromTempInFahrenheit
        }
        
        return toTemp
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("From units", selection: $selectedFromUnitType) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("From temp", value: $fromTemp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($fromTempIsFocused)
                } header: {
                    Text("From units")
                }
                
                Section {
                    Picker("To units", selection: $selectedToUnitType) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text("To temp: \(toTemp.formatted())")
                } header: {
                    Text("To units")
                }
            }
            .navigationTitle("Challenge 01")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        fromTempIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
