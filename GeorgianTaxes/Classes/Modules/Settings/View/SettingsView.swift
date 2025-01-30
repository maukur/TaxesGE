import SwiftUI

struct SettingsView: View {
    @State var viewState: SettingsViewState
    
    @State private var showingBackupConfirmation = false
    @State private var showingRestoreConfirmation = false

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
            
            Section(header: Text("Backup")) {
                if let lastBackupDate = viewState.lastBackupDate {
                    Text("Last Backup: \(formattedDate(lastBackupDate))")
                        .foregroundColor(.gray)
                } else {
                    Text("No backups yet")
                        .foregroundColor(.gray)
                }
                
                Button(action: {
                    showingBackupConfirmation = true
                }) {
                    Text("Backup to iCloud")
                }
                .alert(isPresented: $showingBackupConfirmation) {
                    Alert(
                        title: Text("Confirm Backup"),
                        message: Text("Do you want to backup your database to iCloud?"),
                        primaryButton: .default(Text("Yes")) {
                            viewState.backupDatabase()
                        },
                        secondaryButton: .cancel(Text("No"))
                    )
                }
                
                Button(action: {
                    showingRestoreConfirmation = true
                }) {
                    Text("Restore from iCloud")
                }
                .alert(isPresented: $showingRestoreConfirmation) {
                    Alert(
                        title: Text("Confirm Restore"),
                        message: Text("Do you want to restore your database from iCloud?"),
                        primaryButton: .default(Text("Yes")) {
                            viewState.restoreDatabase()
                        },
                        secondaryButton: .cancel(Text("No"))
                    )
                }
            }
            
            // Сообщение об ошибке
            if let errorMessage = viewState.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            // Сообщение об успешном выполнении
            if let successMessage = viewState.successMessage {
                Text(successMessage)
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .navigationTitle("Settings")
        .onAppear {
            viewState.loadLastBackupDate()
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .long
        return formatter.string(from: date)
    }
}
