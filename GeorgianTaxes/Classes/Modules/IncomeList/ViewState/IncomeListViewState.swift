// IncomeListViewState.swift
import SwiftUI

final class IncomeListViewState: ObservableObject, IncomeListViewStateProtocol {
    private var presenter: IncomeListProtocol?
    @Published private(set) var sections: [YearSection] = []

    func setPresenter(_ presenter: IncomeListProtocol) {
        self.presenter = presenter
    }

    func updateSections(_ sections: [YearSection]) {
        withAnimation {
            self.sections = sections
        }
    }
    
    func onAppear() {
        presenter?.onAppear()
    }
    
    func didTapAddIncome() {
        presenter?.didTapAddIncome()
    }
    
    func didTapSettings() {
        presenter?.didTapSettings()
    }
    
    func deleteItems(at offsets: IndexSet, in monthSec: MonthSection, yearId: Int) {
        let itemsToDelete = offsets.map { monthSec.items[$0] }
        presenter?.delete(items: itemsToDelete)
    }
}
