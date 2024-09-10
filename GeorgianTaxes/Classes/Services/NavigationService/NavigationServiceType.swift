//
//  NavigationServiceType.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25
//  
//

import Foundation

protocol NavigationServiceType: ObservableObject, Identifiable {
    var items:[Views] { get set }
    var modalView: Views? { get set }
    var alert: CustomAlert? { get set }
}
