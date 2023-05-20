//
//  ScannerVIew.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import AlertToast
import SwiftUI
import VisionKit

struct CameraScannerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var startScanning = false
    @State private var showInvalidTextToast = false
    @Binding var scannedText: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CameraView(
                startScanning: $startScanning,
                scanText: $scannedText,
                showInvalidTextToast: $showInvalidTextToast
            )
            
            ScanTextInfoView()
        }
        .toast(isPresenting: $showInvalidTextToast) {
            AlertToast(
                displayMode: .banner(.pop),
                type: .regular,
                title: "Invalid Math Equations")
        }
        .task {
            if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                startScanning.toggle()
            }
        }
        .onChange(of: scannedText) { newValue in
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ScannerVIew_Previews: PreviewProvider {
    static var previews: some View {
        CameraScannerView(
            scannedText: .constant("")
        )
    }
}
