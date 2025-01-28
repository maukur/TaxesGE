// SettingsInteractor.swift
import Foundation

final class SettingsInteractor: SettingsInteractorProtocol {
    private let securityService: SecurityServiceType

    init(securityService: SecurityServiceType) {
        self.securityService = securityService
    }

    func saveSecurityState(_ isEnabled: Bool) {
        securityService.setSecurityEnabled(isEnabled)
    }

    func loadSecurityState() -> Bool {
        return securityService.isSecurityEnabled()
    }
}
