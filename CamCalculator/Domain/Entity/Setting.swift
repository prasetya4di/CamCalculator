//
//  Setting.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation

enum DatabaseSource: String {
	case file = "file"
    case realmDb = "realm_db"
}

struct Setting {
    let databaseSource: DatabaseSource
}
