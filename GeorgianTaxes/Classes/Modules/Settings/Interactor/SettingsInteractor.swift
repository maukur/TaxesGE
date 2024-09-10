// SettingsInteractor.swift
import Foundation

final class SettingsInteractor: SettingsInteractorProtocol {
    private let userDefaults = UserDefaults.standard

    func saveSecurityState(_ isEnabled: Bool) {
        userDefaults.set(isEnabled, forKey: "securityEnabled")
    }

    func loadSecurityState() -> Bool {
        return userDefaults.bool(forKey: "securityEnabled")
    }
}
