// SettingsContracts.swift
import SwiftUI

protocol SettingsRouterProtocol: RouterProtocol {
    func navigateBack()
}

protocol SettingsPresenterProtocol: PresenterProtocol {
    func toggleSecurity(_ isEnabled: Bool)
}

protocol SettingsViewStateProtocol: ViewStateProtocol {
    func setPresenter(_ presenter: SettingsPresenterProtocol)
    func updateSecurityState(_ isEnabled: Bool)
}

protocol SettingsInteractorProtocol: InteractorProtocol {
    func saveSecurityState(_ isEnabled: Bool)
    func loadSecurityState() -> Bool
}
