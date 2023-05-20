//
//  UpdateDatabaseSource.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Combine
import Foundation

protocol UpdateDatabaseSource {
    func call(_ source: DatabaseSource) throws
}

class UpdateDatabaseSourceImpl: UpdateDatabaseSource {
    private let repository: SettingRepository
    
    init(repository: SettingRepository) {
        self.repository = repository
    }
    
    func call(_ source: DatabaseSource) throws {
        let setting = Setting(databaseSource: source)
        try repository.update(setting)
    }
}
