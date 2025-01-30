//
//  BackupServiceType.swift
//  GeorgianTaxes
//
//  Created by Artem Tishchenko on 1/28/25
//	
//

import Foundation

protocol BackupServiceType {
    func backupDatabase() async throws
    func restoreDatabase() async throws
    func getLastBackupDate() async throws -> Date?
}
