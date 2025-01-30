// SettingsViewState.swift
import SwiftUI

final class SettingsViewState: ObservableObject, SettingsViewStateProtocol {
    private var presenter: SettingsPresenterProtocol?
    @Published var securityEnabled = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var lastBackupDate: Date?

    func setPresenter(_ presenter: SettingsPresenterProtocol) {
        self.presenter = presenter
    }

    func toggleSecurity(_ isEnabled: Bool) {
        presenter?.toggleSecurity(isEnabled)
    }

    func updateSecurityState(_ isEnabled: Bool) {
        securityEnabled = isEnabled
    }

    func showError(_ message: String) {
        Task { @MainActor in
            self.errorMessage = message
        }
    }

    func showSuccess(_ message: String) {
        Task { @MainActor in
            self.successMessage = message
        }
    }

    func updateLastBackupDate(_ date: Date?) {
        withAnimation {
            lastBackupDate = date
        }
    }

    func backupDatabase() {
        presenter?.backupDatabase()
    }

    func restoreDatabase() {
        presenter?.restoreDatabase()
    }

    func loadLastBackupDate() {
        presenter?.loadLastBackupDate()
    }
}
