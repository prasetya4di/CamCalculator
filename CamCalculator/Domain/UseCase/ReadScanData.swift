//
//  ReadScanData.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation

protocol ReadScanData {
    func call() -> [ScanData]
}

class ReadScanDataImpl: ReadScanData {
    private let repository: ScanDataRepository
    
    init(repository: ScanDataRepository) {
        self.repository = repository
    }
    
    func call() -> [ScanData] {
        return repository.read()
    }
}
