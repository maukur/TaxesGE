//
//  TaxAssembly.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25.
//


import SwiftUI
import SwiftUI
import Foundation
import Foundation

final class IncomeListAssembly: Assembly {
    

    func build() -> some View {
        let navigation = container.resolve(NavigationAssembly.self).build()

        let storage = container.resolve(StorageDataServiceAssembly.self).build()
        let incomeDataService = container.resolve(IncomeItemDataServiceAssembly.self).build(storage: storage)
        let currencyService = container.resolve(CurrencyConversionServiceAssembly.self).build()

        let router = IncomeListRouter(navigation: navigation)
        let interactor = IncomeListInteractor(incomeService: incomeDataService,
                                      currencyService: currencyService)
        let viewState = IncomeListViewState()
        let presenter = IncomeListPresenter(router: router,
                                     interactor: interactor,
                                     viewState: viewState)
        viewState.setPresenter(presenter)

        return IncomeListView(viewState: viewState)
    }
}
