//
//  ApplicationViewBuilder.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25
//  
//

import SwiftUI

final class ApplicationViewBuilder : Assembly, ObservableObject {
    
    required init(container: Container) {
        super.init(container: container)
    }
   
    @ViewBuilder
    func build(view: Views) -> some View {
        switch view {
        case .addIncome:
            buildAddIncome()
        case .login:
            buildLogin()
        case .incomesList:
            buildTax()
        case .settings:
            buildSettings()
        }
    }
    
    @ViewBuilder
    fileprivate func buildAddIncome() -> some View {
        container.resolve(AddIncomeAssembly.self).build()
    }
    
    @ViewBuilder
    fileprivate func buildTax() -> some View {
        container.resolve(IncomeListAssembly.self).build()
    }
    
    @ViewBuilder
    fileprivate func buildSettings() -> some View {
        container.resolve(SettingsAssembly.self).build()
    }
    
    @ViewBuilder
    fileprivate func buildLogin() -> some View {
        container.resolve(LoginAssembly.self).build()
    }
    
}

extension ApplicationViewBuilder {
    
    static var stub: ApplicationViewBuilder {
        return ApplicationViewBuilder(
            container: RootApp().container
        )
    }
}
