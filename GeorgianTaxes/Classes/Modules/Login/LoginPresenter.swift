// LoginPresenter.swift
import SwiftUI

final class LoginPresenter: LoginPresenterProtocol {
    private weak var viewState: LoginViewStateProtocol?
    private let router: LoginRouterProtocol
    private let interactor: LoginInteractorProtocol

    init(router: LoginRouterProtocol, interactor: LoginInteractorProtocol, viewState: LoginViewStateProtocol) {
        self.router = router
        self.interactor = interactor
        self.viewState = viewState
    }

    func login(withPin pin: String) {
        if interactor.validatePin(pin) {
            router.navigateToHome()
        } else {
            viewState?.showError("Invalid PIN")
        }
    }

    func loginWithFaceID() {
        Task {
            let success = await interactor.authenticateWithFaceID()
            if success {
                await MainActor.run {
                    router.navigateToHome()
                }
            } else {
                viewState?.showError("Face ID is not set up or authentication failed")
            }
        }
    }

    func setNewPin(_ pin: String, confirmPin: String) {
        if pin == confirmPin {
            interactor.saveNewPin(pin)
            router.navigateToHome() // Переход на главную страницу после установки пин-кода
        } else {
            viewState?.showError("PINs do not match")
        }
    }

    func isPinSet() -> Bool {
        return interactor.isPinSet()
    }
}
