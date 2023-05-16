//
//  ScannerVIew.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI
import VisionKit

struct ScannerView: View {
    @State private var startScanning = false
    @State private var scannedText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Scanned Text: \(scannedText)")
                .padding()
            
            CameraView(startScanning: $startScanning, scanText: $scannedText)
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
        ScannerView()
    }
}
