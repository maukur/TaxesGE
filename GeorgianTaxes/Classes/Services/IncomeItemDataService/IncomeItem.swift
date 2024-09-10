//
//  IncomeItemDataService.swift
//  DeclarationsGE
//
//  Created by Artem Tishchenko on 10.09.24.
//

import RealmSwift
import Foundation

final class IncomeItemEntity: Object, Codable  {
    
    override init() {
        super.init()
    }
    
    init(id: UUID, name: String, date: Date, income: Double, incomeCurrency: String, selectedCurrency: String, selectedCurrencyRate: Double, totalInSelectedCurrency: Double) {
        super.init()
        self.id = id
        self.name = name
        self.date = date
        self.income = income
        self.incomeCurrency = incomeCurrency
        self.selectedCurrency = selectedCurrency
        self.selectedCurrencyRate = selectedCurrencyRate
        self.totalInSelectedCurrency = totalInSelectedCurrency
    }
    
    init(item: IncomeItem) {
        super.init()
        self.id = item.id
        self.name = item.name
        self.date = item.date
        self.income = item.income
        self.incomeCurrency = item.incomeCurrency
        self.selectedCurrency = item.selectedCurrency
        self.selectedCurrencyRate = item.selectedCurrencyRate
        self.totalInSelectedCurrency = item.totalInSelectedCurrency
    }
    
    
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var name: String
    @Persisted var date: Date
    @Persisted var income: Double
    @Persisted var incomeCurrency: String
    @Persisted var selectedCurrency: String
    @Persisted var selectedCurrencyRate: Double
    @Persisted var totalInSelectedCurrency: Double
    
}

struct IncomeItem: Codable, Equatable, Hashable  {
    
    init(id: UUID, name: String, date: Date, income: Double, incomeCurrency: String, selectedCurrency: String, selectedCurrencyRate: Double, totalInSelectedCurrency: Double) {
        self.id = id
        self.name = name
        self.date = date
        self.income = income
        self.incomeCurrency = incomeCurrency
        self.selectedCurrency = selectedCurrency
        self.selectedCurrencyRate = selectedCurrencyRate
        self.totalInSelectedCurrency = totalInSelectedCurrency
    }
    
    
    init(item: IncomeItemEntity) {
        self.id = item.id
        self.name = item.name
        self.date = item.date
        self.income = item.income
        self.incomeCurrency = item.incomeCurrency
        self.selectedCurrency = item.selectedCurrency
        self.selectedCurrencyRate = item.selectedCurrencyRate
        self.totalInSelectedCurrency = item.totalInSelectedCurrency
    }
    
    let id: UUID
    let name: String
    let date: Date
    let income: Double
    let incomeCurrency: String
    let selectedCurrency: String
    let selectedCurrencyRate: Double
    let totalInSelectedCurrency: Double
    
}
