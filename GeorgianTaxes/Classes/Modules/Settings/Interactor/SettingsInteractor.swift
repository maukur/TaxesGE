// SettingsInteractor.swift
import Foundation


final class SettingsInteractor: SettingsInteractorProtocol {
    private let securityService: SecurityServiceType
    private let backupService: BackupServiceType

    init(securityService: SecurityServiceType, backupService: BackupServiceType) {
        self.securityService = securityService
        self.backupService = backupService
    }

    func saveSecurityState(_ isEnabled: Bool) {
        securityService.setSecurityEnabled(isEnabled)
    }

    func loadSecurityState() -> Bool {
        return securityService.isSecurityEnabled()
    }

    func backupDatabase() async throws {
        try await backupService.backupDatabase()
    }

    func restoreDatabase() async throws {
        try await backupService.restoreDatabase()
    }

    func getLastBackupDate() async throws -> Date? {
        return try await backupService.getLastBackupDate()
    }
}
