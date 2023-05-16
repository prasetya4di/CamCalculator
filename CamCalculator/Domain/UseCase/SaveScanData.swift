//
//  SaveScanData.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation

protocol SaveScanData {
    func call(_ input: String, _ result: String) async throws -> ScanData
}

class SaveScanDataImpl: SaveScanData {
    private let repository: ScanDataRepository
    
    init(_ repository: ScanDataRepository) {
        self.repository = repository
    }
    
    func call(_ input: String, _ result: String) async throws -> ScanData {
        let data = ScanData(
            input: input,
            result: result,
            createdDate: .now
        )
        try await repository.save(data)
        return data
    }
}
