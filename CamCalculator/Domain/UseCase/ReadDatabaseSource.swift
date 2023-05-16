//
//  ReadDatabaseSource.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation

protocol ReadDatabaseSource {
    func call() throws -> DatabaseSource
}

class ReadDatabaseSourceImpl: ReadDatabaseSource {
    private let repository: SettingRepository
    
    init(repository: SettingRepository) {
        self.repository = repository
    }
    
    func call() throws -> DatabaseSource {
        return try repository.read().databaseSource
    }
}
