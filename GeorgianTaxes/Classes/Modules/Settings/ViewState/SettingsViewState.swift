// SettingsViewState.swift
import SwiftUI

final class SettingsViewState: ObservableObject, SettingsViewStateProtocol {
    private var presenter: SettingsPresenterProtocol?
    @Published var securityEnabled = false

    func setPresenter(_ presenter: SettingsPresenterProtocol) {
        self.presenter = presenter
    }

    func toggleSecurity(_ isEnabled: Bool) {
        presenter?.toggleSecurity(isEnabled)
    }

    func updateSecurityState(_ isEnabled: Bool) {
        securityEnabled = isEnabled
    }
}
