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
    func update(_ setting: SettingTable) async throws
}

class SettingLocalSourceImpl: SettingLocalSource {
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func read() throws -> SettingTable {
        return realm
            .object(
                ofType: SettingTable.self,
                forPrimaryKey: "setting")!
    }
    
    func update(_ setting: SettingTable) async throws {
        try! await realm.asyncWrite {
            realm.add(
                setting,
                update: .all
            )
        }
    }
}
