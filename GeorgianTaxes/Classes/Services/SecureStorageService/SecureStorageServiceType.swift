//
//  SecureStorageServiceType.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 1/28/25
//	
//

import Foundation

protocol SecureStorageServiceType {
    func save(_ value: String, forKey key: String) -> Bool
    func load(forKey key: String) -> String?
    func delete(forKey key: String) -> Bool
}
