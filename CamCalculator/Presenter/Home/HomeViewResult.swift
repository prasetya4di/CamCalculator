//
//  HomeViewResult.swift
//  CamCalculator
//
//  Created by Prasetya on 18/05/23.
//

import Foundation

enum HomeViewResult {
    case fetchAllDataResult(_ status: FetchAllDataStatus)
    case changeDatabaseSourceResult(_ status: ChangeDatabaseSourceStatus)
    case insertScanDataResult(_ status: InsertScanDataStatus)
    case scanImageResult(_ status: ScanImageStatus)
    case nothing
    
    enum FetchAllDataStatus {
        case loading
        case success(
            _ databaseSource: DatabaseSource,
            _ scanDatas: [ScanData]
        )
        case error(_ error: Error)
    }
    
    enum ChangeDatabaseSourceStatus {
        case loading
        case success(
            _ databaseSource: DatabaseSource,
            _ scanDatas: [ScanData]
        )
        case error(_ error: Error)
    }
    
    enum InsertScanDataStatus {
        case loading
    	case success(
            _ scanData: ScanData
        )
        case error(_ error: Error)
    }
    
    enum ScanImageStatus {
        case loading
        case success(
            _ scanData: ScanData
        )
        case error(_ error: Error)
    }
}
