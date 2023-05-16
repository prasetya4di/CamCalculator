//
//  EncryptedFileManager.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation
import CryptoKit

class EncryptedFileManager<T: Codable> {
    
    private let encryptionKey: SymmetricKey
    private let filePath: URL
    
    init(filePath: URL, packageName: String) {
        self.filePath = filePath
        self.encryptionKey = SymmetricKey(
            data: SHA256.hash(
                data: Data(packageName.utf8)
            )
        )
    }
    
    // MARK: - Public Methods
    
    func saveData(_ data: T) throws {
        let jsonData = try JSONEncoder().encode(data)
        let encryptedData = try encryptData(jsonData)
        try encryptedData.write(to: filePath)
    }
    
    func loadData() throws -> [T]? {
        let encryptedData = try Data(contentsOf: filePath)
        guard let decryptedData = try decryptData(encryptedData) else {
            return nil
        }
        return try JSONDecoder().decode([T].self, from: decryptedData)
    }
    
    func deleteFile() throws {
        try FileManager.default.removeItem(at: filePath)
    }
    
    // MARK: - Private Methods
    
    private func encryptData(_ data: Data) throws -> Data {
        return try AES.GCM.seal(data, using: encryptionKey).combined!
    }
    
    private func decryptData(_ data: Data) throws -> Data? {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(sealedBox, using: encryptionKey)
    }
}
