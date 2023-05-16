//
//  UpdateDatabaseSource.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Combine
import Foundation

protocol UpdateDatabaseSource {
    func call(_ source: DatabaseSource) async throws
}

class UpdateDatabaseSourceImpl: UpdateDatabaseSource {
    private let repository: SettingRepository
    
    init(repository: SettingRepository) {
        self.repository = repository
    }
    
    func call(_ source: DatabaseSource) async throws {
        let setting = Setting(databaseSource: source)
        try await repository.update(setting)
    }
}
