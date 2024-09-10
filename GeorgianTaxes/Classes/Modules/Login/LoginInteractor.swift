// LoginInteractor.swift
import Foundation

final class LoginInteractor: LoginInteractorProtocol {
    private let secureStorageService: SecureStorageServiceType
    private let faceIDService: FaceIDServiceType

    init(secureStorageService: SecureStorageServiceType, faceIDService: FaceIDServiceType) {
        self.secureStorageService = secureStorageService
        self.faceIDService = faceIDService
    }

    func validatePin(_ pin: String) -> Bool {
        return pin == secureStorageService.load(forKey: "userPin")
    }

    func authenticateWithFaceID() async -> Bool {
        return await faceIDService.authenticate()
    }

    func saveNewPin(_ pin: String) {
        secureStorageService.save(pin, forKey: "userPin")
    }

    func isPinSet() -> Bool {
        return secureStorageService.load(forKey: "userPin") != nil
    }
}
