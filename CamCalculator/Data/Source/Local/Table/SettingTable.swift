//
//  SettingTable.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation
import RealmSwift

class SettingTable: Object, Codable {
    @Persisted(primaryKey: true) var _id: String = "setting"
    @Persisted var databaseSource: String
    
    convenience init(databaseSource: String) {
        self.init()
        self.databaseSource = databaseSource
    }
    
    func toEntity() -> Setting {
        return Setting(
            databaseSource: DatabaseSource(
                rawValue: databaseSource)!
        )
    }
}
