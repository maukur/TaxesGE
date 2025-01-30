//
//  RootApp.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25
//  
//

import SwiftUI

@main
struct RootApp: App {
    
    @ObservedObject var appViewBuilder: ApplicationViewBuilder
    @ObservedObject var navigationService: NavigationService
    
    let container: DependencyContainer = {
        let factory = AssemblyFactory()
        let container = DependencyContainer(assemblyFactory: factory)
                
        // Services
        container.apply(NavigationAssembly.self)
        container.apply(StorageDataServiceAssembly.self)
        container.apply(CurrencyConversionServiceAssembly.self)
        container.apply(IncomeItemDataServiceAssembly.self)
        container.apply(SecureStorageServiceAssembly.self) // Добавляем SecureStorageServiceAssembly
        container.apply(FaceIDServiceAssembly.self) // Добавляем FaceIDServiceAssembly
        container.apply(SecurityServiceAssembly.self) 
        container.apply(BackupServiceAssembly.self) 
    
        
        // Modules
        container.apply(AddIncomeAssembly.self)
        container.apply(SettingsAssembly.self)
        container.apply(IncomeListAssembly.self)
        container.apply(LoginAssembly.self)


        return container
    }()

    init() {
        navigationService = container.resolve(NavigationAssembly.self).build() as! NavigationService
        appViewBuilder = ApplicationViewBuilder(container: container)
        
        let securityService = container.resolve(SecurityServiceAssembly.self).build()
        if securityService.isSecurityEnabled() {
            navigationService.modalView = .login
        } 
    }
    
    
    var body: some Scene {
        WindowGroup {
            RootView(navigationService: navigationService,
                     appViewBuilder: appViewBuilder)
        }
    }
    
    
}
