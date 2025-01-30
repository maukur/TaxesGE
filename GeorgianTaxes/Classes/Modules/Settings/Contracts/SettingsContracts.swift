// SettingsContracts.swift
import SwiftUI

protocol SettingsRouterProtocol: RouterProtocol {
    func navigateBack()
}

protocol SettingsPresenterProtocol: AnyObject {
    func toggleSecurity(_ isEnabled: Bool)
    func backupDatabase()
    func restoreDatabase()
    func loadLastBackupDate()
}


protocol SettingsViewStateProtocol: AnyObject {
    func setPresenter(_ presenter: SettingsPresenterProtocol)
    func toggleSecurity(_ isEnabled: Bool)
    func updateSecurityState(_ isEnabled: Bool)
    func showError(_ message: String)
    func showSuccess(_ message: String)
    func updateLastBackupDate(_ date: Date?)
    func backupDatabase()
    func restoreDatabase()
    func loadLastBackupDate()
}

protocol SettingsInteractorProtocol: AnyObject {
    func saveSecurityState(_ isEnabled: Bool)
    func loadSecurityState() -> Bool
    func backupDatabase() async throws
    func restoreDatabase() async throws
    func getLastBackupDate() async throws -> Date?
}
