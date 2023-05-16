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
    @State private var startScanning = false
    @State private var showInvalidTextToast = false
    @State private var scannedText = ""
    
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
    }
}

struct ScannerVIew_Previews: PreviewProvider {
    static var previews: some View {
        CameraScannerView()
    }
}
