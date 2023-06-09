//
//  ScanLocalSource.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation
import RealmSwift

protocol ScanLocalSource {
    func read() throws -> [ScanDataTable]
    func insert(_ scanData: ScanDataTable) throws
}

class ScanLocalSourceImpl: ScanLocalSource {
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func read() throws -> [ScanDataTable] {
        return realm.objects(ScanDataTable.self).map { $0 }
    }
    
    func insert(_ scanData: ScanDataTable) throws {
        try! realm.write {
            realm.add(scanData)
        }
    }
}
