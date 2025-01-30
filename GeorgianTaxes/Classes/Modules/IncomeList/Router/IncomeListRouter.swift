//
//  TaxRouter.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25.
//
import Foundation

final class IncomeListRouter: IncomeListRouterProtocol {
    private let navigation: any NavigationServiceType
    
    init(navigation: any NavigationServiceType) {
        self.navigation = navigation
    }
    
    func navigateToAddIncome(didFinished: (()->Void)?) {
        navigation.items.append(.addIncome(didFinished: didFinished))
    }
    
    func navigateToSettings(didFinished: (()->Void)?) {
        navigation.items.append(.settings(didFinished:didFinished))
    }
}
