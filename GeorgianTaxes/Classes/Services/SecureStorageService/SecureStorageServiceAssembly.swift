//
//  SecureStorageServiceAssembly.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 1/28/25
//	
//

import Foundation

class SecureStorageServiceAssembly: Assembly {
    func build() -> SecureStorageServiceType {
        let service = SecureStorageService()
        return service
    }
}
