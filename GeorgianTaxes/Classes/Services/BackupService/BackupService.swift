import Foundation
import RealmSwift
final class BackupService: BackupServiceType {
 
    func getLastBackupDate() -> Date? {
        let backupURL = iCloudContainerURL.appendingPathComponent(realmURL.lastPathComponent)
        guard let attributes = try? FileManager.default.attributesOfItem(atPath: backupURL.path),
              let modificationDate = attributes[.modificationDate] as? Date else {
            return nil
        }
        return modificationDate
    }
    
   // MARK: - Properties
   private let realmURL: URL
   private let iCloudContainerURL: URL
   private let storageDataService: StorageDataServiceType
   // MARK: - Initialization
    init(storageDataService:StorageDataServiceType,
    realmURL: URL = Realm.Configuration.defaultConfiguration.fileURL!,
         iCloudContainerIdentifier: String = "iCloud.com.artem.tishchenko.taxesGE.container") {
        self.realmURL = realmURL
        // Получаем URL контейнера iCloud
        guard let containerURL = FileManager.default.url(forUbiquityContainerIdentifier: iCloudContainerIdentifier) else {
            fatalError("iCloud контейнер не доступен. Убедитесь, что iCloud настроен правильно и устройство подключено к интернету.")
        }
        
        self.storageDataService = storageDataService
        self.iCloudContainerURL = containerURL.appendingPathComponent("Backups")
        // Создаем папку для резервных копий, если её нет
        createBackupDirectoryIfNeeded()
    }
   // MARK: - Public Methods
   /// Создает резервную копию базы данных Realm в iCloud
   func backupDatabase() async throws {
       // Закрываем Realm, чтобы убедиться, что файл не заблокирован
       try await storageDataService.writeCopy(toFile: realmURL)
       let backupURL = iCloudContainerURL.appendingPathComponent(realmURL.lastPathComponent)
       // Копируем файл в iCloud
       try await copyFile(from: realmURL, to: backupURL)
   }
   /// Восстанавливает базу данных Realm из резервной копии в iCloud
   func restoreDatabase() async throws {
       let backupURL = iCloudContainerURL.appendingPathComponent(realmURL.lastPathComponent)
       // Проверяем, существует ли резервная копия
       guard FileManager.default.fileExists(atPath: backupURL.path) else {
           throw BackupError.backupNotFound
       }

       try await copyFile(from: backupURL, to: realmURL)
       try await storageDataService.invalidate()
   }
   // MARK: - Private Methods
   private func createBackupDirectoryIfNeeded() {
       if !FileManager.default.fileExists(atPath: iCloudContainerURL.path) {
           do {
               try FileManager.default.createDirectory(at: iCloudContainerURL, withIntermediateDirectories: true, attributes: nil)
           } catch {
               fatalError("Не удалось создать директорию для резервных копий в iCloud: \(error)")
           }
       }
   }
   /// Копирует файл из одного URL в другой с поддержкой асинхронного выполнения
   private func copyFile(from sourceURL: URL, to destinationURL: URL) async throws {
       try await withCheckedThrowingContinuation { continuation in
           DispatchQueue.global(qos: .background).async {
               do {
                   // Удаляем существующий файл по назначению, если он есть
                   if FileManager.default.fileExists(atPath: destinationURL.path) {
                       try FileManager.default.removeItem(at: destinationURL)
                   }
                   try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
                   continuation.resume()
               } catch {
                   continuation.resume(throwing: error)
               }
           }
       }
   }
   // MARK: - Error Handling
   enum BackupError: Error, LocalizedError {
       case backupNotFound
       var errorDescription: String? {
           switch self {
           case .backupNotFound:
               return "Резервная копия не найдена в iCloud."
           }
       }
   }
}
