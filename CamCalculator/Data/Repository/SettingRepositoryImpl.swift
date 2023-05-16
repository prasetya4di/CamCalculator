//
//  SettingRepositoryImpl.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation

class SettingRepositoryImpl: SettingRepository {
    private let settingLocalSource: SettingLocalSource
    
    init(settingLocalSource: SettingLocalSource) {
        self.settingLocalSource = settingLocalSource
    }
    
    func read() throws -> Setting {
        return try settingLocalSource.read().toEntity()
    }
    
    func update(_ setting: Setting) async throws {
        try await settingLocalSource.update(
            SettingTable(
                databaseSource: setting.databaseSource.rawValue))
    }
}
