//
//  StorageDataServiceType.swift
//  duelpassion
//
//  Created by Macbook on 16.01.2024
//	
//

import Foundation
import RealmSwift

protocol StorageDataServiceType: AnyObject{
    func insert<T: Object>(contentsOf: [T]) async
    func clear<T: Object>(_ type: T.Type) async
    func all<T: Object, T2: Hashable>(_ _in: T.Type,maper: @escaping (T) -> T2) async -> [T2]
    func update<T: Object>(items: [T]) async
    func update<T: Object>(item: T) async
    func delete<T: Object>(items: [T]) async
    func delete<T: Object>(_ type: T.Type, by ids: [UUID]) async
    
}

