// SettingsRouter.swift
import Foundation

final class SettingsRouter: SettingsRouterProtocol {
    var navigation: any NavigationServiceType

    init(navigation: any NavigationServiceType) {
        self.navigation = navigation
    }

    func navigateBack() {
        navigation.items.removeLast()
    }
}
