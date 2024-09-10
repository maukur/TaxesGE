//
//  RootView.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 23.01.25
//  
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject var navigationService: NavigationService
    @ObservedObject var appViewBuilder: ApplicationViewBuilder
    
    var body: some View {
        NavigationStack(path: $navigationService.items) {
            appViewBuilder.build(view: .login)
                .navigationDestination(for: Views.self) { path in
                    appViewBuilder.build(view: path)
                }
        }
        .fullScreenCover(isPresented: .constant($navigationService.modalView.wrappedValue != nil)) {
            if let modal = navigationService.modalView {
                switch modal {
                default:
                    fatalError()
                }
            }
        }
        .alert(isPresented: .constant($navigationService.alert.wrappedValue != nil)) {
            switch navigationService.alert {
            case .defaultAlert(let yesAction, let noAction):
                return Alert(title: Text("Title"),
                             primaryButton: .default(Text("Yes"), action: yesAction),
                             secondaryButton: .destructive(Text("No"), action: noAction))
            case .none:
                fatalError()
            }
        }
        
    }
}
