//
//  ScanDataTable.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation
import RealmSwift

class ScanDataTable: Object, Codable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var result: String
    @Persisted var createdDate: Date
    
    convenience init(result: String, createdDate: Date) {
        self.init()
        self.result = result
        self.createdDate = createdDate
    }
    
    func toEntity() -> ScanData {
        return ScanData(
            result: result,
            createdDate: createdDate
        )
    }
}
