// LoginContracts.swift
import SwiftUI

protocol LoginRouterProtocol: RouterProtocol {
    func navigateToHome()
}

protocol LoginPresenterProtocol: PresenterProtocol {
    func login(withPin pin: String)
    func loginWithFaceID()
    func setNewPin(_ pin: String, confirmPin: String)
    func isPinSet() -> Bool
}

protocol LoginViewStateProtocol: ViewStateProtocol {
    func setPresenter(_ presenter: LoginPresenterProtocol)
    func showError(_ message: String)
    func showSuccess(_ message: String)
}

protocol LoginInteractorProtocol: InteractorProtocol {
    func validatePin(_ pin: String) -> Bool
    func authenticateWithFaceID() async -> Bool
    func saveNewPin(_ pin: String)
    func isPinSet() -> Bool
}
