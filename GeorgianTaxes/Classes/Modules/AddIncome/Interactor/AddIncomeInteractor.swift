//
//  MainInteractor.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25
//  
//

import Foundation

// MARK: - AddIncomeInteractor
final class AddIncomeInteractor: AddIncomeInteractorProtocol {
    private let dataService: any IncomeItemDataServiceType
    private let currencyService: any CurrencyConversionServiceType

    init(dataService: any IncomeItemDataServiceType,
         currencyService:  any CurrencyConversionServiceType) {
        self.dataService = dataService
        self.currencyService = currencyService
    }

    /// Создаёт новую запись в базе, конвертируя сумму из USD в GEL
    func createIncome(date: Date, amount: Double, name: String) async throws {
        // 1. Получаем курс обмена через CurrencyConversionService
        let rate = try await currencyService.fetchRate(for: "USD", date: date)
        
        // 2. Вычисляем GEL-сумму
        let gelValue = amount * rate

        // 3. Формируем новый IncomeItem
        let newItem = IncomeItem(
            id: UUID(),
            name: name,
            date: date,
            income: amount,              // USD
            incomeCurrency: "USD",
            selectedCurrency: "GEL",
            selectedCurrencyRate: rate,
            totalInSelectedCurrency: gelValue
        )

        // 4. Сохраняем через DataService
        await dataService.insert(items: [newItem])
    }
}
