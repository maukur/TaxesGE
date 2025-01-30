//
//  MainPresenter.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25
//  
//

import SwiftUI

final class AddIncomePresenter: AddIncomePresenterProtocol {
    func close() {
        router.dismiss()
    }
    
    // weak
    private weak var viewState: AddIncomeViewStateProtocol?
    private let router: AddIncomeRouterProtocol
    private let interactor: AddIncomeInteractorProtocol
    private let didFinished: (()->Void)?

    
    public init(router: AddIncomeRouterProtocol,
                interactor: AddIncomeInteractorProtocol,
                viewState: AddIncomeViewStateProtocol,
                didFinished: (()->Void)?) {
        self.router = router
        self.interactor = interactor
        self.viewState = viewState
        self.didFinished = didFinished
    }
    
    func addIncome(date: Date, amount: Double, name: String) {
        Task {
            do {
                try await interactor.createIncome(date: date, amount: amount, name: name)
                await MainActor.run {
                    router.dismiss()
                }
            } catch {
                // обработка ошибки
            }
        }
    }
    
}
