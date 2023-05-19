//
//  ScanData.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation

struct ScanData: Identifiable, Equatable {
    let id: UUID = UUID()
    let input: String
    let result: String
    let createdDate: Date
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        return dateFormatter.string(from: createdDate)
    }
    
    static func == (lhs: ScanData, rhs: ScanData) -> Bool {
        return lhs.id == rhs.id
        && lhs.input == rhs.input
        && lhs.result == rhs.result
        && lhs.createdDate == rhs.createdDate
    }
}
