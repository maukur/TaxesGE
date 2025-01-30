import SwiftUI

final class SettingsAssembly: Assembly {
    func build(didFinished:(()->Void)?) -> some View {
        let navigation = container.resolve(NavigationAssembly.self).build()
        
        // Services
        let securityService = container.resolve(SecurityServiceAssembly.self).build()
        let backupService = container.resolve(BackupServiceAssembly.self).build()
        
        // Interactor
        let interactor = SettingsInteractor(securityService: securityService, backupService: backupService)
        
        // ViewState
        let viewState = SettingsViewState()
        
        // Presenter
        let presenter = SettingsPresenter(router: SettingsRouter(navigation: navigation), interactor: interactor, viewState: viewState, didFinished: didFinished)
        
        viewState.setPresenter(presenter)
        
        // View
        let view = SettingsView(viewState: viewState)
        return view
    }
}
