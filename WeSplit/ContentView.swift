import SwiftUI

struct ContentView: View {
    @State private var totalCheckAmount = 0.0
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalBill: Double {
        let numberOfPeople = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
   
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection:  $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
//                    .pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave?") {
                        Picker("Tip pecentage", selection: $tipPercentage) {
                            //                        ForEach(tipPercentages, id: \.self) {
                            //                            Text($0, format: .percent)
                            //                        }
                            ForEach(0..<101) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.navigationLink)
                }
                Section("Bill INCLUDING TIP") {
                    Text(totalBill, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("We Split")
            
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
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

//https://www.hackingwithswift.com/books/ios-swiftui/hiding-the-keyboard
