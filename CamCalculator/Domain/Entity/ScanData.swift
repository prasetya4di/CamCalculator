//
//  ScanData.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation

struct ScanData: Identifiable {
    let id: UUID = UUID()
    let input: String
    let result: String
    let createdDate: Date
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        return dateFormatter.string(from: createdDate)
    }
}
