//
//  MainAssembly.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25
//  
//


import SwiftUI

final class AddIncomeAssembly: Assembly {
    
    func build() -> some View {
        
        let navigation = container.resolve(NavigationAssembly.self).build()
        let storage = container.resolve(StorageDataServiceAssembly.self).build()
        let incomeDataService = container.resolve(IncomeItemDataServiceAssembly.self).build(storage: storage)
        let currencyService = container.resolve(CurrencyConversionServiceAssembly.self).build()
        // Router
        let router = AddIncomeRouter(navigation: navigation)
    
        
        // Interactor
        let interactor = AddIncomeInteractor(dataService: incomeDataService, currencyService: currencyService)

        //ViewState
        let viewState =  AddIncomeViewState()

        // Presenter
        let presenter = AddIncomePresenter(router: router,
                                                           interactor: interactor,
                                                           viewState: viewState)
        
        viewState.setPresenter(presenter)
        
        // View
        let view = AddIncomeView(viewState: viewState)
        return view
    }
}
