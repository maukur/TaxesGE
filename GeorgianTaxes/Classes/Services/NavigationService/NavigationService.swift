//
//  NavigationService.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25
//  
//


import SwiftUI

public class NavigationService: NavigationServiceType  {
    
    public let id = UUID()
    
    public static func == (lhs: NavigationService, rhs: NavigationService) -> Bool {
        lhs.id == rhs.id
    }
    
    @Published var modalView: Views?
    @Published var items: [Views] = []
    @Published var alert: CustomAlert?
}


enum Views: Equatable, Hashable {
    
    static func == (lhs: Views, rhs: Views) -> Bool {
        lhs.stringKey == rhs.stringKey
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.stringKey)
    }
    
    case addIncome
    case incomesList
    case login
    case settings
    
    var stringKey: String {
        switch self {
        case .addIncome:
            return "main"
        case .login:
            return "login"
        case .incomesList:
            return "tax"
        case .settings:
            return "settings"
        }
    }
}


class StubNavigation: NavigationServiceType, ObservableObject, Equatable  {
    @Published var modalView: Views?
    @Published var alert: CustomAlert?
    
    public let id = UUID()
    
    public static func == (lhs: StubNavigation, rhs: StubNavigation) -> Bool {
        lhs.id == rhs.id
    }
    
    fileprivate init() {}
    
    static var stub: any NavigationServiceType { NavigationService() }
    
    @Published var items: [Views] = []
}

enum CustomAlert: Equatable, Hashable {
    static func == (lhs: CustomAlert, rhs: CustomAlert) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .defaultAlert:
            hasher.combine("defaultAlert")
        }
    }
    
    case defaultAlert(yesAction: (()->Void)?, noAction: (()->Void)?)
}
