//
//  ScanDataRepositoryImpl.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation

class ScanDataRepositoryImpl: ScanDataRepository {
    private let settingLocalSource: SettingLocalSource
    private let scanLocalSource: ScanLocalSource
    private let scanEncryptedFile: ScanLocalSource
    
    init(settingLocalSource: SettingLocalSource, scanLocalSource: ScanLocalSource, scanEncryptedFile: ScanLocalSource) {
        self.settingLocalSource = settingLocalSource
        self.scanLocalSource = scanLocalSource
        self.scanEncryptedFile = scanEncryptedFile
    }
    
    func read() throws -> [ScanData] {
        switch try checkSource() {
            case .realmDb:
                return try scanLocalSource.read().map { $0.toEntity() }
            case .file:
                return try scanEncryptedFile.read().map { $0.toEntity() }
        }
    }
    
    func save(_ scanData: ScanData) throws {
        let data = ScanDataTable(
            input: scanData.input,
            result: scanData.result,
            createdDate: scanData.createdDate
        )
        switch try checkSource() {
            case .realmDb:
                try scanLocalSource.insert(data)
            case .file:
                try scanEncryptedFile.insert(data)
        }
    }
    
    private func checkSource() throws -> DatabaseSource {
        return try DatabaseSource(
            rawValue: settingLocalSource.read().databaseSource
        ) ?? .realmDb
    }
}
