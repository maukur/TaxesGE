//
//  SecurityServiceAssembly.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 1/28/25
//	
//

import Foundation

class SecurityServiceAssembly: Assembly {
    func build() -> SecurityServiceType {
        let secureStorageService = container.resolve(SecureStorageServiceAssembly.self).build()
        return SecurityService(secureStorageService: secureStorageService)
    }
}
