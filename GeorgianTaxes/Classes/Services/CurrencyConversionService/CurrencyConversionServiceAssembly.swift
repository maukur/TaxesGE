//
//  CurrencyConversionServiceAssembly.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25.
//


import SwiftUI
import SwiftUI
import Foundation
import Foundation

final class CurrencyConversionServiceAssembly: Assembly {
    func build() -> CurrencyConversionServiceType {
        return CurrencyConversionService()
    }
}