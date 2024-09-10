//
//  CurrencyConversionService.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25.
//


import SwiftUI
import SwiftUI
import Foundation
import Foundation

final class CurrencyConversionService: CurrencyConversionServiceType {
    func fetchRate(for currency: String, date: Date) async throws -> Double {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        guard let url = URL(string: "https://nbg.gov.ge/gw/api/ct/monetarypolicy/currencies/?currencies=\(currency)&date=\(dateString)") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        // Здесь нужно распарсить структуру ответа, адаптированную к реальному JSON
        // Допустим, ответ вида: [{ "currencies":[ { "code":"USD", "rate":2.50 } ] }]
        let decoded = try JSONSerialization.jsonObject(with: data) as? [[String:Any]]
        guard let first = decoded?.first,
              let array = first["currencies"] as? [[String:Any]],
              let dict = array.first,
              let rate = dict["rate"] as? Double else {
            throw URLError(.cannotParseResponse)
        }
        return rate
    }
}