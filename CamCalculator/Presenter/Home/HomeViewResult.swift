//
//  HomeViewResult.swift
//  CamCalculator
//
//  Created by Prasetya on 18/05/23.
//

import Foundation

enum HomeViewResult {
    case fetchAllDataResult(_ status: fetchAllDataStatus)
    case changeDatabaseSourceResult(_ status: changeDatabaseSourceStatus)
    case insertScanDataResult(_ status: insertScanDataStatus)
    case nothing
    
    enum fetchAllDataStatus {
        case loading
        case success(
            _ databaseSource: DatabaseSource,
            _ scanDatas: [ScanData]
        )
        case error(_ error: Error)
    }
    
    enum changeDatabaseSourceStatus {
        case loading
        case success(
            _ databaseSource: DatabaseSource,
            _ scanDatas: [ScanData]
        )
        case error(_ error: Error)
    }
    
    enum insertScanDataStatus {
        case loading
    	case success(
            _ scanData: ScanData
        )
        case error(_ error: Error)
    }
}
