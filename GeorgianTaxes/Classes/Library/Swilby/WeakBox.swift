//
//  WeakBox.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25
//  
//

import Foundation

protocol WeakBox: AnyObject {
    var weakBoxHolder: [String : WeakContainer<AnyObject>] { set get}
}

extension WeakBox {
    func weakBox<T>(_ configure: () -> T) -> T {
        let key = ObjectKey(T.self).key
        if let object = self.weakBoxHolder[key]?.value as? T {
            return object
        }
        let object = configure()
        weakBoxHolder[key] = WeakContainer(value: object as AnyObject)
        return object
    }
}
