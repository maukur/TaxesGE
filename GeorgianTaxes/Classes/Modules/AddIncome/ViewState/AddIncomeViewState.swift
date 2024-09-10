//
//  MainViewState.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25
//  
//

import SwiftUI

final class AddIncomeViewState: AddIncomeViewStateProtocol, ObservableObject {
    private var presenter: AddIncomePresenterProtocol?

    func setPresenter(_ presenter: AddIncomePresenterProtocol) {
        self.presenter = presenter
    }

    // Вызывается из View при нажатии "Save"
    func addIncome(date: Date, amount: Double, name: String) {
        presenter?.addIncome(date: date, amount: amount, name: name)
    }

    // Вызывается из View при нажатии "Cancel"
    func closeView() {
        presenter?.close()
    }
}
