//
//  HomeView.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var photoScannerModel = PhotoPickerModel()
    @State private var databaseSource: DatabaseSource = .realmDb
    let scanDatas: [ScanData]
    
    var body: some View {
        ScrollView {
            VStack {
                PickerDatabaseSource(databaseSource: $databaseSource)
                ScanResults(scanDatas: scanDatas)
                Spacer()
            }
        }
        .navigationTitle("Cam Calculator")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ScanToolbarButton(viewModel: photoScannerModel)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let scanData = ScanData(
            input: "2 + 3",
            result: "5",
            createdDate: .now
        )
        
        HomeView(
        	scanDatas: [
                scanData,
                scanData,
                scanData,
                scanData,
            	scanData,
            ]
        )
    }
}
