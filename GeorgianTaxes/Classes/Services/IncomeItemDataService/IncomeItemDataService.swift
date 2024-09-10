//
//  IncomeItemDataService.swift
//  DeclarationsGE
//
//  Created by Artem Tishchenko on 10.09.24
//	
//

import Foundation
class IncomeItemDataService: IncomeItemDataServiceType {
    
    let storage: StorageDataServiceType
    
    init(storage: StorageDataServiceType){
        self.storage = storage
    }
    
    func insert(items: [IncomeItem]) async {
        await storage.update(items: items.map {IncomeItemEntity(item: $0)})
    }
    
    func read(by id: UUID) async -> IncomeItem? {
        let all = await storage.all(IncomeItemEntity.self, maper: { IncomeItem(item: $0 )})
        return all.filter { $0.id == id }.first
    }
    
    func update(items: [IncomeItem]) async {
        await storage.update(items: items.map { IncomeItemEntity(item: $0)})
    }
    
    func update(item: IncomeItem) async {
        await storage.update(item: IncomeItemEntity(item: item))
    }
    
    func delete(items: [IncomeItem]) async {
        let ids = items.map { $0.id }
        await storage.delete(IncomeItemEntity.self,by: ids)
    }
    
    func all() async -> [IncomeItem] {
        await storage.all(IncomeItemEntity.self, maper: {IncomeItem(item: $0)})
    }
    
    func clear() async {
        await storage.clear(IncomeItemEntity.self)
    }
}
