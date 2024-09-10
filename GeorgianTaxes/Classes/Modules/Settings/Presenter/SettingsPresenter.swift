// SettingsPresenter.swift
import SwiftUI

final class SettingsPresenter: SettingsPresenterProtocol {
    private weak var viewState: SettingsViewStateProtocol?
    private let router: SettingsRouterProtocol
    private let interactor: SettingsInteractorProtocol

    init(router: SettingsRouterProtocol, interactor: SettingsInteractorProtocol, viewState: SettingsViewStateProtocol) {
        self.router = router
        self.interactor = interactor
        self.viewState = viewState
        loadSecurityState()
    }

    func toggleSecurity(_ isEnabled: Bool) {
        interactor.saveSecurityState(isEnabled)
        viewState?.updateSecurityState(isEnabled)
    }

    private func loadSecurityState() {
        let isEnabled = interactor.loadSecurityState()
        viewState?.updateSecurityState(isEnabled)
    }
}
