//
//  Setting.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation

enum DatabaseSource {
	case file
    case realmDb
}

struct Setting {
    let databaseSource: DatabaseSource
}
