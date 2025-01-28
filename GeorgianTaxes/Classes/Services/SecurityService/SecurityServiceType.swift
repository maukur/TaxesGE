//
//  SecurityServiceType.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 1/28/25
//	
//

import Foundation

protocol SecurityServiceType {
    func isSecurityEnabled() -> Bool
    func setSecurityEnabled(_ isEnabled: Bool)
}
