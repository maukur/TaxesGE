// LoginView.swift
import SwiftUI

struct LoginView: View {
    @ObservedObject var viewState: LoginViewState
    @State private var pin = ""
    @State private var confirmPin = ""
    @State private var isSettingPin = false

    var body: some View {
        VStack(spacing: 20) {
            if isSettingPin {
                SecureField("Enter new PIN", text: $pin)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                SecureField("Confirm new PIN", text: $confirmPin)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    viewState.setNewPin(pin, confirmPin: confirmPin)
                }) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Set PIN")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
            } else {
                SecureField("Enter PIN", text: $pin)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    viewState.login(withPin: pin)
                }) {
                    HStack {
                        Image(systemName: "lock.fill")
                        Text("Login with PIN")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                Button(action: {
                    viewState.loginWithFaceID()
                }) {
                    HStack {
                        Image(systemName: "faceid")
                        Text("Login with Face ID")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
            }
            
            if let errorMessage = viewState.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top)
            }
            
            if let successMessage = viewState.successMessage {
                Text(successMessage)
                    .foregroundColor(.green)
                    .padding(.top)
            }
        }
        .onAppear {
            isSettingPin = !viewState.isPinSet()
        }
        .navigationTitle("Login")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationViewBuilder.stub.build(view: .login)
    }
}
