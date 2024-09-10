
import SwiftUI

final class LoginViewState: ObservableObject, LoginViewStateProtocol {
    private var presenter: LoginPresenterProtocol?
    @Published var errorMessage: String?
    @Published var successMessage: String?

    func setPresenter(_ presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }

    func login(withPin pin: String) {
        presenter?.login(withPin: pin)
    }

    func loginWithFaceID() {
        presenter?.loginWithFaceID()
    }

    func setNewPin(_ pin: String, confirmPin: String) {
        presenter?.setNewPin(pin, confirmPin: confirmPin)
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

    func isPinSet() -> Bool {
        return presenter?.isPinSet() ?? false
    }
}
