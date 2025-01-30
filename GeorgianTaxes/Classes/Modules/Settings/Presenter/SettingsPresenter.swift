import Foundation

final class SettingsPresenter: SettingsPresenterProtocol {
    private weak var viewState: SettingsViewStateProtocol?
    private let router: SettingsRouterProtocol
    private let interactor: SettingsInteractorProtocol
    private let didFinished: (()->Void)?

    init(router: SettingsRouterProtocol, interactor: SettingsInteractorProtocol, viewState: SettingsViewStateProtocol, didFinished: (()->Void)?) {
        self.router = router
        self.interactor = interactor
        self.viewState = viewState
        self.didFinished = didFinished
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

    func backupDatabase() {
        Task {
            do {
                try await interactor.backupDatabase()
                let lastBackupDate = try await interactor.getLastBackupDate()
                await MainActor.run {
                    viewState?.showSuccess("Backup successful")
                    viewState?.updateLastBackupDate(lastBackupDate)
                }
            } catch {
                await MainActor.run {
                    viewState?.showError("Backup failed: \(error.localizedDescription)")
                }
            }
        }
    }

    func restoreDatabase() {
        Task {
            do {
                try await interactor.restoreDatabase()
                await MainActor.run {
                    viewState?.showSuccess("Restore successful")
                }
                didFinished?()
            } catch {
                await MainActor.run {
                    viewState?.showError("Restore failed: \(error.localizedDescription)")
                }
            }
        }
    }

    func loadLastBackupDate() {
        Task {
            let lastBackupDate = try? await interactor.getLastBackupDate()
            await MainActor.run {
                viewState?.updateLastBackupDate(lastBackupDate)
            }
        }
    }
}
