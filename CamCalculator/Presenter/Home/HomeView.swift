//
//  HomeView.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @StateObject private var photoScannerModel = PhotoPickerModel()
    private var scannedText: Binding<String> {
        Binding<String> (
            get : {
                return ""
            },
            set: { input in
                viewModel.dispatch(.insertScan(input))
            }
        )
    }
    
    private var databaseSource: Binding<DatabaseSource> {
        Binding<DatabaseSource> (
            get: {
                return viewModel.viewState.databaseSource
            },
            set: { newValue in
                viewModel.dispatch(.changeDatabaseSource(newValue))
            }
        )
    }
    
    var body: some View {
        ScrollView {
            VStack {
                PickerDatabaseSource(databaseSource: databaseSource)
                ScanResults(scanDatas: viewModel.viewState.scanDatas)
                Spacer()
            }
        }
        .onAppear {
            viewModel.dispatch(.getAllData)
        }
        .navigationTitle("Cam Calculator")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ScanToolbarButton(
                    scannedText: scannedText,
                    viewModel: photoScannerModel
                )
            }
        }
    }
}
