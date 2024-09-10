// SettingsView.swift
import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewState: SettingsViewState

    var body: some View {
        Form {
            Section(header: Text("Security")) {
                Toggle(isOn: $viewState.securityEnabled) {
                    HStack {
                        Image(systemName: "lock.fill")
                        Text("Enable Security (PIN/Face ID)")
                    }
                }
                .onChange(of: viewState.securityEnabled) { isEnabled in
                    viewState.toggleSecurity(isEnabled)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationViewBuilder.stub.build(view: .settings)
    }
}
