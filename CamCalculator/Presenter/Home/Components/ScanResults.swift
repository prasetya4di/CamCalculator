//
//  ScanResults.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI

struct ScanResults: View {
    let isLoading: Bool
    let scanDatas: [ScanData]
    
    var body: some View {
        VStack {
            if isLoading {
                LoadingView()
            } else {
                ForEach(scanDatas) { data in
                    ScanResultItem(scanData: data)
                }
            }
        }
    }
}

struct ScanResults_Previews: PreviewProvider {
    static var previews: some View {
        let scanData = ScanData(
            input: "2 + 3",
            result: "5",
            createdDate: .now
        )
        
        ScanResults(
            isLoading: false,
            scanDatas: [
            scanData,
            scanData,
            scanData,
            scanData,
        	scanData,
        ])
    }
}
