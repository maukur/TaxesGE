//
//  AddIncomeContracts.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25
//  
//

import SwiftUI
protocol AddIncomeRouterProtocol: RouterProtocol {
    func dismiss()
}

protocol AddIncomePresenterProtocol: PresenterProtocol {
    func addIncome(date: Date, amount: Double, name: String)
    func close()
}

protocol AddIncomeViewStateProtocol: ViewStateProtocol {
    func setPresenter(_ presenter: AddIncomePresenterProtocol) 
    func addIncome(date: Date, amount: Double, name: String)
    func closeView()
}

protocol AddIncomeInteractorProtocol: InteractorProtocol {
    func createIncome(date: Date, amount: Double, name: String) async throws
}
