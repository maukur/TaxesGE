//
//  IncomeItemDataServiceAssembly.swift
//  DeclarationsGE
//
//  Created by Artem Tishchenko on 10.09.24
//	
//

import Foundation

class IncomeItemDataServiceAssembly: Assembly {
    func build(storage: StorageDataServiceType) -> any IncomeItemDataServiceType {
        let service = IncomeItemDataService(storage: storage)
        return service
    }
}
