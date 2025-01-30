//
//  StorageDataService.swift
//  NeverEver
//
//  Created by Macbook on 08.11.2023
//
//

import Foundation
import RealmSwift

final class StorageDataService : StorageDataServiceType {
    
    
    fileprivate var realm: Realm?
    fileprivate let backgroundQueee: DispatchQueue
    
    
    init() {
        backgroundQueee = DispatchQueue(label: "realm-queue")
        backgroundQueee.sync { [weak self] in
            guard let self else {
                return
            }
            
            let configuration = Realm.Configuration(schemaVersion: UInt64(Constants.Versions.dataBaseVersion), deleteRealmIfMigrationNeeded: false)
            do {
                self.realm = try Realm(configuration: configuration, queue: backgroundQueee)
            } catch {
               // Amplitude.instance().logEvent("Error", withEventProperties: ["realm": error.localizedDescription])
            }
        }
    }
    
    func all<T: Object, T2: Hashable>(_ _in: T.Type, maper: @escaping (T) -> T2) async -> [T2] {
        do {
            return try await withUnsafeThrowingContinuation({ [weak self] res in
                guard let self else {
                    res.resume(with: .success([]))
                    return
                }
                backgroundQueee.async {
                    guard let realm =  self.realm else {
                        res.resume(with: .success([]))
                        return
                    }
                    let items = realm.objects(_in)
                    res.resume(with: .success(items.map{ maper($0)}))
                }
            })
        } catch {
            return []
        }
    }
    
    func insert<T: Object>(contentsOf: [T]) async  {
        do {
            try await withUnsafeThrowingContinuation { [weak self] res in
                guard let self else {
                    res.resume()
                    return
                }
                backgroundQueee.async {
                    guard let realm = self.realm else {
                        res.resume()
                        return
                    }
                    try? realm.write {
                        realm.add(contentsOf, update: .all)
                    }
                    res.resume()
                }
            }
        } catch {
            assertionFailure("Delete")
        }
        
    }
    
    func clear<T: Object>(_ type: T.Type) async  {
        do {
            try await withUnsafeThrowingContinuation { [weak self] res in
                guard let self else {
                    res.resume()
                    return
                }
                backgroundQueee.async {
                    guard let realm = self.realm else {
                        res.resume()
                        return
                    }
                    try? realm.write {
                        let items = realm.objects(type)
                        realm.delete(items)
                    }
                    res.resume()
                    
                }
            }
        } catch {
            assertionFailure("Delete")
        }
        
    }
    
    func delete<T: Object>(items: [T]) async {
        do {
            try await withUnsafeThrowingContinuation { [weak self] res in
                guard let self else {
                    res.resume()
                    return
                }
                backgroundQueee.async {
                    guard let realm =  self.realm else {
                        res.resume()
                        return
                    }
                    try? realm.write {
                        realm.delete(items)
                    }
                    res.resume()
                }
            }
        } catch {
            assertionFailure("Delete")
        }
    }
    
    func delete<T>(_ type: T.Type, by ids: [UUID]) async where T : Object {
        do {
            try await withUnsafeThrowingContinuation { [weak self] res in
                guard let self else {
                    res.resume()
                    return
                }
                backgroundQueee.async {
                    guard let realm =  self.realm else {
                        res.resume()
                        return
                    }
                    
                    let items = realm.objects(T.self).filter("id IN %@", ids)
                    
                    try? realm.write {
                        realm.delete(items)
                    }
                    res.resume()
                }
            }
        } catch {
            assertionFailure("Delete")
        }
    }
    
    
    func update<T: Object>(items: [T]) async {
        do {
            try await withUnsafeThrowingContinuation {[weak self] res in
                guard let self else {
                    res.resume()
                    return
                }
                backgroundQueee.async {
                    guard let realm =  self.realm else {
                        res.resume()
                        return
                    }
                    try? realm.write {
                        realm.add(items, update: .all)
                    }
                    res.resume()
                }
            }
        } catch {
            assertionFailure("Update")
        }
    }
    
    func update<T: Object>(item: T) async {
        do {
            try await withUnsafeThrowingContinuation {[weak self] res in
                guard let self else {
                    res.resume()
                    return
                }
                backgroundQueee.async {
                    guard let realm =  self.realm else {
                        res.resume()
                        return
                    }
                    try? realm.write {
                        realm.add(item, update: .all)
                    }
                    res.resume()
                }
            }
        } catch {
            assertionFailure("Update")
        }
    }
    
    
    func exportDatabase() async throws -> Data {
        guard let realm = realm else {
            throw NSError(domain: "StorageDataService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Realm is not initialized"])
        }
        
        let fileURL = realm.configuration.fileURL!
        return try Data(contentsOf: fileURL)
    }

    // Новый метод для импорта базы данных
    func importDatabase(from data: Data) async throws {
        guard let realm = realm else {
            throw NSError(domain: "StorageDataService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Realm is not initialized"])
        }
        
        let fileURL = realm.configuration.fileURL!
        try data.write(to: fileURL, options: .atomic)
    }
    
     func writeCopy(toFile: URL) async throws {
        do {
            try await withUnsafeThrowingContinuation {[weak self] res in
                guard let self else {
                    res.resume()
                    return
                }
                backgroundQueee.async {
                    guard let realm =  self.realm else {
                        res.resume()
                        return
                    }
                    try? realm.write {
                        try realm.writeCopy(toFile: toFile)
                    }
                    res.resume()
                }
            }
        } catch {
            assertionFailure("Update")
        }
               
         
    }
    
     func invalidate() async throws {
        do {
            try await withUnsafeThrowingContinuation {[weak self] res in
                guard let self else {
                    res.resume()
                    return
                }
                backgroundQueee.sync {
                    let configuration = Realm.Configuration(schemaVersion: UInt64(Constants.Versions.dataBaseVersion), deleteRealmIfMigrationNeeded: false)
                    do {
                        self.realm = try Realm(configuration: configuration, queue: self.backgroundQueee)
                    } catch {
                        print(error)
                    }
                    res.resume()
                }
            }
        } catch {
            assertionFailure("invalidate")
        }
               
         
    }
}


enum Constants {
    enum Versions {
        static let dataBaseVersion = 1
    }
}
