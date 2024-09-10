//
//  NavigationAssembly.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25
//  
//

import Foundation

final class NavigationAssembly: Assembly {
    
    //Only one navigation should use in app
    static let navigation: any NavigationServiceType = NavigationService()
    
    func build() -> any NavigationServiceType {
        return NavigationAssembly.navigation
    }
}
