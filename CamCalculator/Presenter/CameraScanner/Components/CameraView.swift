//
//  CameraView.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI
import UIKit
import VisionKit

struct CameraView: UIViewControllerRepresentable {
    
    @Binding var scanning: Bool
    @Binding var scanText: String
    @Binding var showInvalidTextToast: Bool
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let controller = DataScannerViewController(
            recognizedDataTypes: [.text()],
            qualityLevel: .balanced,
            isHighlightingEnabled: true
        )
        
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        
        if scanning {
            try? uiViewController.startScanning()
        } else {
            uiViewController.stopScanning()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
                case .text(let text):
                    guard let result = text
                        .transcript
                        .extractMatchingSubstring(
                            with: supportedMathPattern
                        ), !result.isEmpty
                    else {
                        parent.showInvalidTextToast.toggle()
                        return
                    }
                    
                    parent.scanText = result
                    parent.scanning = false
                    dataScanner.stopScanning()
                default: break
            }
        }
    }
}
