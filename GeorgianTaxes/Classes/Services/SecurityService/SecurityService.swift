//
//  SecurityService.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 1/28/25
//	
//

import Foundation

final class SecurityService: SecurityServiceType {
    private let secureStorageService: SecureStorageServiceType

    init(secureStorageService: SecureStorageServiceType) {
        self.secureStorageService = secureStorageService
    }

    func isSecurityEnabled() -> Bool {
        return secureStorageService.load(forKey: "securityEnabled") == "true"
    }

    func setSecurityEnabled(_ isEnabled: Bool) {
        secureStorageService.save(isEnabled ? "true" : "false", forKey: "securityEnabled")
    }
}
