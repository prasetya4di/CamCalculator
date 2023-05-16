//
//  ScanDataRepository.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation

protocol ScanDataRepository {
    func read() throws -> [ScanData]
    func save(_ scanData: ScanData) async throws
}
