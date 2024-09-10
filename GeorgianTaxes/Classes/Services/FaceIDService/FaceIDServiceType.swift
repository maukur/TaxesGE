//
//  FaceIDServiceType.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 1/28/25
//	
//

import Foundation

protocol FaceIDServiceType {
    func authenticate() async -> Bool 
}

