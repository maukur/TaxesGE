//
//  TaxInteractor.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25.
//


import SwiftUI

struct YearMonth: Hashable {
    let year: Int
    let month: Int
}

final class IncomeListInteractor: IncomeListInteractorProtocol {
    private let incomeService: any IncomeItemDataServiceType
    private let currencyService: CurrencyConversionServiceType

    init(incomeService: any IncomeItemDataServiceType,
         currencyService: CurrencyConversionServiceType) {
        self.incomeService = incomeService
        self.currencyService = currencyService
    }

    func loadData() async throws -> [YearSection] {
        let allItems = await incomeService.all()
        let grouped = groupItemsByYearMonth(allItems)
        return grouped
    }

    func deleteItems(_ items: [IncomeItem]) async throws {
        await incomeService.delete(items: items)
    }
    
    // Пример из Interactor или любого места, где группируются доходы и считается налог.
    private func groupItemsByYearMonth(_ items: [IncomeItem]) -> [YearSection] {
        let calendar = Calendar.current
        
        // Группируем все IncomeItem по (год, месяц)
        let grouped = Dictionary(grouping: items) { (item) -> YearMonth in
            let comps = calendar.dateComponents([.year, .month], from: item.date)
            return YearMonth(year: comps.year ?? 0, month: comps.month ?? 0)
        }
        
        // Группируем по годам
        let yearGroups = Dictionary(grouping: grouped.keys, by: { $0.year })
        
        var yearSections = [YearSection]()
        
        for (year, yearTuples) in yearGroups {
            var monthSections: [MonthSection] = []
            
            for monthPair in yearTuples {
                let itemsInMonth = grouped[monthPair] ?? []
                
                // Суммируем весь доход в GEL
                let totalGEL = itemsInMonth.reduce(0) { $0 + $1.totalInSelectedCurrency }
                
                // Считаем налог 1% от GEL
                let tax = totalGEL * 0.01
                
                monthSections.append(
                    MonthSection(id: monthPair.month,
                                 items: itemsInMonth,
                                 totalTax: tax)
                )
            }
            // Сортируем месяцы
            monthSections.sort { $0.id < $1.id }
            
            // Формируем секцию по году
            yearSections.append(
                YearSection(id: year, months: monthSections)
            )
        }
        
        // Сортируем годы (например, по убыванию)
        yearSections.sort { $0.id > $1.id }
        
        return yearSections
    }

}
