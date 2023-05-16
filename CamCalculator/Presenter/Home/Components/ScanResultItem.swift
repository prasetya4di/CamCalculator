//
//  ScanResultItem.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI

struct ScanResultItem: View {
    let scanData: ScanData
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Input : \(scanData.input)")
                Text("Result : \(scanData.result)")
            }
            Spacer()
            Text(scanData.formattedDate)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 4)
                .stroke(.red, lineWidth: 0.45)
        }
        .padding()
    }
}

struct ScanResultItem_Previews: PreviewProvider {
    static var previews: some View {
        ScanResultItem(
        	scanData: ScanData(
                input: "2 + 3",
                result: "5",
                createdDate: .now)
        )
    }
}
