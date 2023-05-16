//
//  ScanEncryptedFileSource.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation

class ScanEcryptedFileSource: ScanLocalSource {
    let fileManager: EncryptedFileManager<ScanDataTable>
    
    init(fileManager: EncryptedFileManager<ScanDataTable>) {
        self.fileManager = fileManager
    }
    
    func read() throws -> [ScanDataTable] {
        return try fileManager.loadData() ?? []
    }
    
    func insert(_ scanData: ScanDataTable) async throws {
        try fileManager.saveData(scanData)
    }
}
