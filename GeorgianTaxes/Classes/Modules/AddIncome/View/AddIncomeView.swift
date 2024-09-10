//
//  MainView.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25
//  
//

import SwiftUI

struct AddIncomeView: View {
    
    @ObservedObject var viewState: AddIncomeViewState
    
    @State private var date = Date()
    @State private var name = ""
    @State private var amountUSD = ""
    
    var body: some View {
        Form {
            Section("Income Info") {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Name", text: $name)
                TextField("Amount (USD)", text: $amountUSD)
                    .keyboardType(.decimalPad)
            }
            Button("Save") {
                if let usd = Double(amountUSD) {
                    // Вызов метода у презентера
                    viewState.addIncome(date: date,
                                        amount: usd,
                                        name: name)
                }
            }
            Button("Cancel") {
                // Закрытие экрана через ViewState
                viewState.closeView()
            }
        }
        .navigationTitle("Add Income")
    }
    
}
struct MainPreviews: PreviewProvider {
    static var previews: some View {
        ApplicationViewBuilder.stub.build(view: .addIncome)
    }
}

