//
//  AbstractDataServiceType.swift
//  duelpassion
//
//  Created by Macbook on 16.01.2024.
//

import RealmSwift
import Foundation

public protocol AbstractDataServiceType {
    associatedtype Item: Hashable
    
    func insert(items: [Item]) async

    func read(by id: UUID)  async -> Item?
    
    func update(items: [Item]) async
    
    func update(item: Item) async
    
    func delete(items: [Item]) async
    
    func all() async -> [Item]
    
    func clear() async
}
