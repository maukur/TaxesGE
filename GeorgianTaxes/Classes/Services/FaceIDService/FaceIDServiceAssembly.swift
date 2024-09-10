//
//  FaceIDServiceAssembly.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 1/28/25
//	
//

import Foundation

class FaceIDServiceAssembly: Assembly {
    func build() -> FaceIDServiceType {
        let service = FaceIDService()
        return service
    }
}
