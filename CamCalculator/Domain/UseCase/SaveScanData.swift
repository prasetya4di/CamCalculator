//
//  SaveScanData.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation

protocol SaveScanData {
    func call(_ result: String) -> ScanData
}

class SaveScanDataImpl: SaveScanData {
    private let repository: ScanDataRepository
    
    init(_ repository: ScanDataRepository) {
        self.repository = repository
    }
    
    func call(_ result: String) -> ScanData {
        let data = ScanData(
            result: result,
            date: .now
        )
        repository.save(data)
        return data
    }
}
