//
//  FaceIDService.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 1/28/25
//	
//

import LocalAuthentication

final class FaceIDService: FaceIDServiceType {
    func authenticate() async -> Bool {
        let context = LAContext()
        var error: NSError?

        return await withCheckedContinuation { continuation in
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate with Face ID") { success, error in
                    continuation.resume(returning: success)
                }
            } else {
                continuation.resume(returning: false)
            }
        }
    }
}
