//
//  HomeView.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import AlertToast
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @StateObject private var photoScannerModel = PhotoPickerModel()
    
    var body: some View {
        ScrollView {
            VStack {
                PickerDatabaseSource(databaseSource: databaseSource)
                ScanResults(
                    isLoading: viewModel.viewState.isLoading,
                    scanDatas: viewModel.viewState.scanDatas
                )
                Spacer()
            }
        }
        .onAppear {
            viewModel.dispatch(.getAllData)
        }
        .toast(isPresenting: showInvalidMathEquations) {
            AlertToast(
                displayMode: .banner(.pop),
                type: .regular,
                title: "Math equation not found")
        }
        .navigationTitle("Cam Calculator")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ScanToolbarButton(
                    scannedText: scannedText,
                    viewModel: photoScannerModel
                ) { image in
                    viewModel.dispatch(.scanImage(image))
                }
            }
        }
    }
}

extension HomeView {
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
    
    private var showInvalidMathEquations: Binding<Bool> {
        Binding<Bool> (
            get: {
                return viewModel.viewState.showInvalidMathEquationToast
            },
            set: { _ in
                viewModel.dispatch(.hideInvalidMathEquationToast)
            }
        )
    }
}
