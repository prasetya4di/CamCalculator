//
//  HomeViewIntent.swift
//  CamCalculator
//
//  Created by Prasetya on 18/05/23.
//

import Foundation

enum HomeViewIntent {
    case getAllData
    case changeDatabaseSource(_ databaseSource: DatabaseSource)
    case insertScan(_ input: String)
}
