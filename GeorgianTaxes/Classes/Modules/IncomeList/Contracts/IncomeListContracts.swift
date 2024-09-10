// IncomeListContracts.swift
import Foundation

protocol IncomeListRouterProtocol: RouterProtocol {
    func navigateToAddIncome()
    func navigateToSettings() // Новый метод для навигации к экрану настроек
}

protocol IncomeListProtocol: PresenterProtocol {
    func onAppear()
    func didTapAddIncome()
    func didTapSettings() // Новый метод для обработки нажатия на кнопку настроек
    func delete(items: [IncomeItem])
}

protocol IncomeListInteractorProtocol: InteractorProtocol {
    func loadData() async throws -> [YearSection]
    func deleteItems(_ items: [IncomeItem]) async throws
}

protocol IncomeListViewStateProtocol: ViewStateProtocol {
    func setPresenter(_ presenter: IncomeListProtocol)
    func updateSections(_ sections: [YearSection])
}


// MARK: - Model для списка на экране
struct YearSection: Identifiable, Hashable {
    let id: Int       // Год
    var months: [MonthSection]
}

struct MonthSection: Identifiable, Hashable {
    let id: Int       // Месяц
    let items: [IncomeItem]
    var totalTax: Double  // 1% от суммы за месяц
}
