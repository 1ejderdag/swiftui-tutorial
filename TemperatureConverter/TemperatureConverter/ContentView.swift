//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Ejder Dağ on 26.03.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var temperature: String = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    
    var units: [String] = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertedValue: String {
        guard !temperature.isEmpty, let tempValue = Double(temperature) else { return "invalid input" }
        
        let convertedValue = convertValue(
            value: tempValue,
            fromUnit: units[inputUnit],
            toUnit: units[outputUnit])
        
        return String(format: "%.2f", convertedValue)
    }
    
    
    func convertValue(value: Double, fromUnit: String, toUnit: String) -> Double {
        
        var baseValue: Double
        
        // Önce girilen sıcaklığı Celsius'a çevir
        switch fromUnit {
        case "Celsius":
            baseValue = value
        case "Fahrenheit":
            baseValue = (value - 32) * 5/9
        case "Kelvin":
            baseValue = value - 273.15
        default:
            return 0
        }
        
       
        switch toUnit {
        case "Celsius":
            return baseValue
        case "Fahrenheit":
            return (baseValue * 9/5) + 32
        case "Kelvin":
            return baseValue + 273.15
        default:
            return 0
        }
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section("Input") {
                    Picker("From", selection: $inputUnit) {
                        ForEach(0..<units.count) { index in
                            Text(units[index])
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Temperature", text: $temperature)
                        .keyboardType(.decimalPad)

                }
                
                Section("Output") {
                    Picker("To", selection: $outputUnit) {
                        ForEach(0..<units.count) { index in
                            Text(units[index])
                        }
                    }
                    
                    Text(convertedValue)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}






/*
 // chatgpt solution
 
import SwiftUI

struct ContentView: View {
    @State private var inputTemperature: String = ""
    @State private var inputUnit: TemperatureUnit = .celsius
    @State private var outputUnit: TemperatureUnit = .fahrenheit
    
    var convertedTemperature: Double? {
        guard let inputValue = Double(inputTemperature) else { return nil }
        return convertTemperature(value: inputValue, from: inputUnit, to: outputUnit)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter Temperature", text: $inputTemperature)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Picker("From", selection: $inputUnit) {
                    ForEach(TemperatureUnit.allCases, id: \..self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Picker("To", selection: $outputUnit) {
                    ForEach(TemperatureUnit.allCases, id: \..self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Text("Converted Temperature:")
                    .font(.headline)
                
                Text(convertedTemperature != nil ? String(format: "%.2f", convertedTemperature!) : "Invalid Input")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Temp Converter")
        }
    }
    
    func convertTemperature(value: Double, from: TemperatureUnit, to: TemperatureUnit) -> Double {
        switch (from, to) {
        case (.celsius, .fahrenheit):
            return (value * 9/5) + 32
        case (.celsius, .kelvin):
            return value + 273.15
        case (.fahrenheit, .celsius):
            return (value - 32) * 5/9
        case (.fahrenheit, .kelvin):
            return (value - 32) * 5/9 + 273.15
        case (.kelvin, .celsius):
            return value - 273.15
        case (.kelvin, .fahrenheit):
            return (value - 273.15) * 9/5 + 32
        default:
            return value
        }
    }
}

enum TemperatureUnit: String, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
}

*/

/*
 
// deepseek solution

import SwiftUI

struct ContentView: View {
    @StateObject private var temperature = TemperatureModel()
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            Form {
                TemperatureSection(
                    title: "Celsius",
                    value: $temperature.celsius,
                    symbol: "℃"
                )
                
                TemperatureSection(
                    title: "Kelvin",
                    value: $temperature.kelvin,
                    symbol: "K"
                )
                
                TemperatureSection(
                    title: "Fahrenheit",
                    value: $temperature.fahrenheit,
                    symbol: "℉"
                )
            }
            .navigationTitle("Temperature Converter")
        }
    }
}

struct TemperatureSection: View {
    let title: String
    @Binding var value: Double
    let symbol: String
    
    var body: some View {
        Section(header: Text(title)) {
            HStack {
                TextField(title, value: $value, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                    .font(.body)
                
                Text(symbol)
                    .foregroundColor(.blue)
            }
        }
    }
}

class TemperatureModel: ObservableObject {
    @Published var celsius: Double = 0 {
        didSet {
            guard !updating else { return }
            updating = true
            kelvin = celsius + 273.15
            fahrenheit = celsius * 9/5 + 32
            updating = false
        }
    }
    
    @Published var kelvin: Double = 273.15 {
        didSet {
            guard !updating else { return }
            updating = true
            celsius = kelvin - 273.15
            fahrenheit = celsius * 9/5 + 32
            updating = false
        }
    }
    
    @Published var fahrenheit: Double = 32 {
        didSet {
            guard !updating else { return }
            updating = true
            celsius = (fahrenheit - 32) * 5/9
            kelvin = celsius + 273.15
            updating = false
        }
    }
    
    private var updating = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

*/
