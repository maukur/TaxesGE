//
//  MainRouter.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25
//  
//

import Foundation

final class AddIncomeRouter: AddIncomeRouterProtocol {
    func dismiss() {
        navigation.items.removeLast()
    }
    
    var navigation: any NavigationServiceType
    
    init(navigation: any NavigationServiceType){
        self.navigation = navigation
    }
       
}
