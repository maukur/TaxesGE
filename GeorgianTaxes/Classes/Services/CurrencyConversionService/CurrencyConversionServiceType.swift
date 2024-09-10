//
//  CurrencyConversionServiceType.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25.
//


import SwiftUI
import SwiftUI
import Foundation
import Foundation

protocol CurrencyConversionServiceType {
    func fetchRate(for currency: String, date: Date) async throws -> Double
}