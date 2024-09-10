//
//  TaxPresenter.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25.
//

import Foundation

final class IncomeListPresenter: IncomeListProtocol {
    private let router: IncomeListRouterProtocol
    private let interactor: IncomeListInteractorProtocol
    private weak var viewState: IncomeListViewStateProtocol?
    
    init(router: IncomeListRouterProtocol, interactor: IncomeListInteractorProtocol, viewState: IncomeListViewStateProtocol) {
        self.router = router
        self.interactor = interactor
        self.viewState = viewState
    }
    
    func onAppear() {
        Task {
            do {
                let sections = try await interactor.loadData()
                await MainActor.run {
                    viewState?.updateSections(sections)
                }
            } catch {
                // обработка ошибок
            }
        }
    }
    
    func delete(items: [IncomeItem]) {
        Task {
            do {
                try await interactor.deleteItems(items)
                let updatedSections = try await interactor.loadData()
                await MainActor.run {
                    viewState?.updateSections(updatedSections)
                }
            } catch {
                // handle error
            }
        }
    }
    
    func didTapAddIncome() {
        router.navigateToAddIncome()
    }
    
    func didTapSettings() {
        router.navigateToSettings()
    }
    
}
