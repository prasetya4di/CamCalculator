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
    @State private var scanning = false
    @State private var showInvalidTextToast = false
    @Binding var scannedText: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CameraView(
                scanning: $scanning,
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
            if DataScannerViewController.isSupported
                && DataScannerViewController.isAvailable {
                scanning.toggle()
            }
        }
        .onChange(of: scanning) { newValue in
            if !scanning {
                self.presentationMode.wrappedValue.dismiss()
            }
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
