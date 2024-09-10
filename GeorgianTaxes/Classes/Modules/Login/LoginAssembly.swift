import SwiftUI

final class LoginAssembly: Assembly {
    func build() -> some View {
        let navigation = container.resolve(NavigationAssembly.self).build()
        
        // Services
        let secureStorageService = container.resolve(SecureStorageServiceAssembly.self).build()
        let faceIDService = container.resolve(FaceIDServiceAssembly.self).build()
        
        // Router
        let router = LoginRouter(navigation: navigation)
        
        // Interactor
        let interactor = LoginInteractor(secureStorageService: secureStorageService, faceIDService: faceIDService)
        
        // ViewState
        let viewState = LoginViewState()
        
        // Presenter
        let presenter = LoginPresenter(router: router, interactor: interactor, viewState: viewState)
        
        viewState.setPresenter(presenter)
        
        // View
        let view = LoginView(viewState: viewState)
        return view
    }
}
