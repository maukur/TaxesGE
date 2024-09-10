//
//  StorageDataServiceAssembly.swift
//  duelpassion
//
//  Created by Macbook on 16.01.2024
//	
//

import Foundation

final class StorageDataServiceAssembly: Assembly {
    fileprivate static let storage = StorageDataService()
    
    func build() -> any StorageDataServiceType {
        return StorageDataServiceAssembly.storage
    }
}
