//
//  SettingLocalSource.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation
import RealmSwift

protocol SettingLocalSource {
    func read() throws -> SettingTable
    func update(_ setting: SettingTable) throws
}

class SettingLocalSourceImpl: SettingLocalSource {
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func read() throws -> SettingTable {
        var setting = realm
            .object(
                ofType: SettingTable.self,
                forPrimaryKey: "setting"
            )
        
        if setting == nil {
            setting = try initData()
        }
        
        return setting!
    }
    
    func update(_ setting: SettingTable) throws {
        try! realm.write {
            realm.add(
                setting,
                update: .all
            )
        }
    }
    
    private func initData() throws -> SettingTable {
        let setting = SettingTable(databaseSource: DatabaseSource.realmDb.rawValue)
        try! realm.write {
            realm.add(
                setting,
                update: .all
            )
        }
        return setting
    }
}
