// LoginRouter.swift
import Foundation

final class LoginRouter: LoginRouterProtocol {
    var navigation: any NavigationServiceType

    init(navigation: any NavigationServiceType) {
        self.navigation = navigation
    }

    func close() {
        navigation.modalView = nil
    }
}
