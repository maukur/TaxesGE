//
//  BackupServiceAssembly.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 1/28/25
//	
//

import Foundation

class BackupServiceAssembly: Assembly {
    func build() -> BackupServiceType {
        let storageService = container.resolve(StorageDataServiceAssembly.self).build()
        return BackupService(storageDataService: storageService)
    }
}
