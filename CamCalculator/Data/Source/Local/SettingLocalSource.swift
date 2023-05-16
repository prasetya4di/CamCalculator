//
//  SettingLocalSource.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation
import RealmSwift

protocol SettingLocalSource {
    func read() -> Setting
    func update(_ setting: Setting) async throws
}

class SettingLocalSourceImpl: SettingLocalSource {
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func read() -> Setting {
        return realm
            .object(
                ofType: SettingTable.self,
                forPrimaryKey: "setting")!
            .toEntity()
    }
    
    func update(_ setting: Setting) async throws {
        try! await realm.asyncWrite {
            realm.add(
                SettingTable(databaseSource: setting.databaseSource.rawValue),
                update: .all
            )
        }
    }
}
