import SwiftUI

final class SettingsAssembly: Assembly {
    func build() -> some View {
        let navigation = container.resolve(NavigationAssembly.self).build()
        let securityService = container.resolve(SecurityServiceAssembly.self).build()
        
        // Router
        let router = SettingsRouter(navigation: navigation)
        
        // Interactor
        let interactor = SettingsInteractor(securityService: securityService)
        
        // ViewState
        let viewState = SettingsViewState()
        
        // Presenter
        let presenter = SettingsPresenter(router: router, interactor: interactor, viewState: viewState)
        
        viewState.setPresenter(presenter)
        
        // View
        let view = SettingsView(viewState: viewState)
        return view
    }
}
